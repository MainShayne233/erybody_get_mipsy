prime_check: l.d     $f12, cons1
             c.eq.d  $f0, $f12
             bc1t    is_not_prime
             l.d     $f12, cons3
             c.eq.d  $f0, $f12
             bc1t    is_prime
             l.d     $f12, cons2
             c.eq.d  $f0, $f12
             bc1t    is_prime
             cvt.w.d $f4, $f0
             cvt.w.d $f2, $f12
             mfc1    $t1, $f4
             mfc1    $t2, $f2
             div     $t1, $t2
             mfhi    $t0
             beqz    $t0, is_not_prime
             l.d     $f4 cons3

prime_check_loop: div.d $f2, $f0, $f4
                  round.w.d $f6, $f2
                  cvt.d.w $f6, $f6
                  c.eq.d $f2, $f6
                  bc1t is_not_prime
                  l.d $f2, cons2
                  add.d $f4, $f4, $f2
                  mul.d $f2, $f4, $f4
                  c.le.d $f0, $f4
                  bc1t is_prime
                  j prime_check_loop

is_prime: addi $v0, $zero, 1
          jr $ra

is_not_prime: addi $v0, $zero, 0
              jr $ra

next_prime: move $t7, $ra

next_prime_loop: l.d $f12, cons1
                 add.d $f0, $f0, $f12
                 jal prime_check
                 beq $v0, $zero, next_prime_loop
                 jr $t7

main:
  l.d $f0, start
  l.d $f14, number

factor_loop: mov.d $f12, $f14
             div.d $f2, $f14, $f0
             mov.d $f4, $f2
             round.w.d $f4, $f4
             cvt.w.d $f4, $f4
             c.le.d $f2, $f4
             bc1f, is_not_factor

             mov.d $f14, $f2
             c.eq.d $f0, $f14
             bc1t end
             j factor_loop

is_not_factor: jal next_prime
               mov.d $f12, $f0
               c.le.d $f14, $f0
               bc1t end
               j factor_loop

end: mov.d $f12, $f0
     li $v0, 3
     syscall

     li $v0, 10
     syscall


           .data
number:    .double, 10086647.0
start:     .double, 839.0
cons1:     .double, 1.0
cons2:     .double, 2.0
cons3:     .double, 3.0
