main:
  l.d $f12, number
  li $v0, 3
  syscall

  li $v0, 10
  syscall


.data
number: .double, 600851475143.0
