.text

#512/4 = 128 gu width
#256/4 = 64 gu height

main:	

#scenario:	
	lui $20, 0x1001
	addi $8, $0, 64 #lines total
	addi $7, $0, 20 #mid line
for_lines: beq $8, $0, end_lines

	addi $9, $0, 128 #columns total
for_columns: beq $9, $0, end_columns

	beq $8, $7, if_mid_line

	addi $5, $0, 0xffffff #background color
	sw $5, 0($20)
	sw $5, 0x8000($20)
	addi $20, $20, 4

	addi $9, $9, -1
	j for_columns
	
if_mid_line: addi $5, $0, 0x151d28 #mid line color
	sw $5, 0($20)
	sw $5, 0x8000($20)
	addi $20, $20, 4
	
	addi $9, $9, -1
	j for_columns
	
end_columns: addi $8, $8, -1
	j for_lines

end_lines:

#scenario -> clouds
#	0xc7cfcc cloud color
#	8 gu line 3 gu columns
	
