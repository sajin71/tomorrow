package strage

/**
 * nbyteのレジスタをあらわすクラス
 */
abstract class Register {
	def bytes: Seq[Byte]
	def bytes_=(bytes: Seq[Byte]): Unit
}