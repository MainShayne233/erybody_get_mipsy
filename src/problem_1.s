# add current incrementer to sum
is_multiple:
  add $a1, $a1, $a0
  j   increment

##
# $a0 = incremented value
# $a1 = accumulated sum
# $t0 = factor 1
# $t1 = factor 2A
# $t2 = limit
main:
  addi $a0, $zero, 1
	addi $a1, $zero, 0
  addi $t0, $zero, 3
	addi $t1, $zero, 5
  addi $t2, $zero, 1000

# divide current incremented value by each factor
# if the remained is 0, call is_multiple
check:
  div  $a0, $t0
  mfhi $t3
  beq  $t3, $zero, is_multiple
  div  $a0, $t1
  mfhi $t3
 	beq  $t3, $zero, is_multiple

# add 1 to incremented value
# if value is still < limit, call check
# otherwise print result and exit
increment:
  addi $a0, $a0, 1
  bne  $a0, $t2, check

  move $a0, $a1
  li   $v0, 1
  syscall

  li $v0, 10
  syscall
