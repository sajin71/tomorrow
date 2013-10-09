package strage

/**
 * @todo dataの型はArray[Byte]でなく、もうちょっと抽象化するべき
 */
class Memory(size: Int) {
    var data: Array[Byte] = new Array[Byte](size)
}