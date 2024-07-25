.text

#512/4 = 128 gu width
#256/4 = 64 gu height

main:	
######################=====scenario=====###############################
# used: $6, $7, $8, $9, $20

	lui $20, 0x1001 
	
	addi $7, $0, 16 #mid line
	addi $8, $0, 64 #lines total
for_lines: 
	beq $8, $0, end_lines

	addi $9, $0, 128 #columns total
for_columns: 
	beq $9, $0, end_columns

	beq $8, $7, if_mid_line

	addi $6, $0, 0xffffff #background color
	sw $6, 0($20)
	sw $6, 0x8000($20) #background backup address
	addi $20, $20, 4

	addi $9, $9, -1
	j for_columns
if_mid_line: 
	addi $6, $0, 0x151d28 #mid line color
	sw $6, 0($20)
	sw $6, 0x8000($20)
	addi $20, $20, 4
	
	addi $9, $9, -1
	j for_columns
end_columns: 
	addi $8, $8, -1
	j for_lines
end_lines:

###########==========player chr============##################
# player block size: 15gu width 17gu height
# used: $7, $8, $9, $20, $25
# up - 512, down + 512, right +4, left -4
	
	addi $25, $0, 0xff00ff # player block color
       	lui $20, 0x1001 #adress start 
       	addi $20, $20, 15892 #actual adress
       	addi $8, $0, 17 #player block height
for_player_lines:
	beq $8, $0, end_player_lines
	
	addi $9, $0, 15 #player block width
for_player_columns:
	beq $9, $0, end_player_columns
	
	sw $25, 0($20)
	addi $20, $20, 4
	
	addi $9, $9, -1
	j for_player_columns
end_player_columns:
	addi $8, $8, -1
	
	addi $20, $20, 452
	
	j for_player_lines
end_player_lines:

###########=====enemie(cactus)========##################
# cactus block size: 10gu width 17gu height
# used: $10, $11, $20, $24

	addi $24, $0, 0x00ff00 # cactus block color
       	lui $20, 0x1001 #adress start 
       	addi $20, $20, 16836 #actual adress
       	addi $10, $0, 16 #cactus block height
for_cactus_lines:
	beq $10, $0, end_cactus_lines
	
	addi $11, $0, 10 #cactus block width
for_cactus_columns:
	beq $11, $0, end_cactus_columns
	
	sw $24, 0($20)
	addi $20, $20, 4
	
	addi $11, $11, -1
	j for_cactus_columns
end_cactus_columns:
	addi $10, $10, -1
	
	addi $20, $20, 472
	
	j for_cactus_lines
end_cactus_lines:
	
#############=====player controls=========####################

#############=======end program===========####################
end: 
	addi $2, $0, 10
	syscall
	
