package test

import extend_view.cui.FormCUI
import cpu.AbstractCPU

/*
 * メモ
 * test.sの内容は、
 * li r1 <- 0x00
 * li r2 <- 0x10
 * li r3 <- 0x20
 * add r1 <- r2 + r3
 */
object TestFormCUI extends FormCUI {
    def makeCPU(): AbstractCPU = {
        new TestCPU()
    }
}