# add last calculated value to sum
is_even:
  add.s $f2, $f2, $f1
  j fib


##
# $f0: first incrementing value
# $f1: second incrementing value
# $f2: incrementing sum
# $f3: limit
# $t0: divisor
main:
  l.s $f0, first
  l.s $f1, second
  l.s $f2, sum
  l.s $f3, limit
  li  $t0, 2

##
# calculate next value
#
# if value is > limit, call end
#
# else, set new $f0 to last second value and
# set $f1 to new value
#
# if new value is even, call is_even
#
# call fib again
fib:
  add.s $f5, $f0, $f1
  c.le.s $f3, $f5
  bc1t end

  mov.s $f0, $f1
  mov.s $f1, $f5

  cvt.w.s $f5, $f5
  mfc1 $t1, $f5
  div $t1, $t0
  mfhi $t1
  beq $t1, $zero, is_even

  j fib

# print value and exit
end:
  cvt.w.s $f2, $f2
  mfc1, $a0, $f2
  li $v0, 1
  syscall

  li $v0, 10
  syscall

        .data
first:  .float, 1.0
second: .float, 2.0
sum:    .float, 2.0
limit:  .float, 4000000.0
