import spark._
import SparkContext._

object SparkHdfsWC {

	def main(args: Array[String]) {
    if (args.length < 5) {
      System.err.println("Usage: SparkHdfsWC <master> <input file> <output file> <spark_home> <jars>")
      System.exit(1)
    }
    System.out.println("args(0): " + args(0))
    System.out.println("args(1): " + args(1))
    System.out.println("args(2): " + args(2))
    System.out.println("args(3): " + args(3))
    System.out.println("args(4): " + args(4))
    //System.out.println("args(5): " + args(5))
    //val sc = new SparkContext(args(0), "SparkHdfsWC", args(3))
    //val sc = new SparkContext(args(0), "SparkHdfsWC", args(3), List(args(4), args(5)))
    val sc = new SparkContext(args(0), "SparkHdfsWC", args(3), List(args(4)))
    val file = sc.textFile(args(1))
    val counts = file.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)
    counts.sortByKey()
    counts.saveAsTextFile(args(2))
    //file.saveAsTextFile(args(2))
    sc.stop()
  }
}
