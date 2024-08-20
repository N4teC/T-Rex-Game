.text

#512/4 = 128 gu width
#256/4 = 64 gu height

# up - 512, down + 512, right +4, left -4

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
player_chr:
       	lui $20, 0x1001 #adress start 
       	addi $20, $20, 15932 #actual adress
       	addi $8, $0, 17 #player block height
for_player_lines:
	beq $8, $0, end_player_lines
	
	addi $9, $0, 15 #player block width
for_player_columns:
	beq $9, $0, end_player_columns
	
	addi $25, $0, 0xff00ff # player block color
	sw $25, 0($20)
	addi $20, $20, 4
	
	addi $9, $9, -1
	j for_player_columns
end_player_columns:
	addi $8, $8, -1
	
	addi $20, $20, 452
	
	j for_player_lines
end_player_lines:
	
###########=====enemie block(cactus)========##################
# cactus block size: 10gu width 17gu height
# used: $10, $11, $12, $19, $20, $21, $22, $24

cactus_builder:
       	lui $20, 0x1001 #adress start 
       	addi $20, $20, 16856 #actual adress
       	
       	addi $23, $0, 0x00ff00 # cactus color
       	
       	addi $6, $0, 13 #paint line start
       	addi $7, $0, 7	#paint line end
       	
       	addi $8, $0, 5 #mid column paint
       	addi $9, $0, 6 #mid column paint 2
       	
       	addi $10, $0, 16 #cactus block height
       	
for_cactus_lines:
	beq $10, $0, end_cactus_lines
	
	addi $11, $0, 10 #cactus block width
for_cactus_columns:
	beq $11, $0, end_cactus_columns
	
	beq $10, $9, paint_cactus
	beq $10, $8, paint_cactus
	
	beq $10, $6, may_paint
	
	beq $11, $9, paint_cactus
	beq $11, $8, paint_cactus
	
not_paint_cactus:
	lw $24, 0x8000($20)
	sw $24, 0($20)
	addi $20, $20, 4
	
	addi $11, $11, -1
	j for_cactus_columns
	
may_paint:
	add $24, $0, $23 
	
	sw $24, 0($20)
	addi $20, $20, 4
	
	sw $24, 0($20)
	addi $20, $20, 4
	
	lw $24, 0x8000($20)
	sw $24, 0($20)
	addi $20, $20, 4
	
	lw $24, 0x8000($20)
	sw $24, 0($20)
	addi $20, $20, 4
	
	add $24, $0, $23 
	sw $24, 0($20)
	addi $20, $20, 4
	
	sw $24, 0($20)
	addi $20, $20, 4
	
	lw $24, 0x8000($20)
	sw $24, 0($20)
	addi $20, $20, 4
	
	lw $24, 0x8000($20)
	sw $24, 0($20)
	addi $20, $20, 4
	
	add $24, $0, $23 
	sw $24, 0($20)
	addi $20, $20, 4
	
	sw $24, 0($20)
	addi $20, $20, 4
	
	addi $11, $11, -10
	
	beq $6, $7, may_paint_sub
	addi $6, $6, -1
	j for_cactus_columns
may_paint_sub:
	j for_cactus_columns

paint_cactus:
	add $24, $0, $23 
	sw $24, 0($20)
	addi $20, $20, 4
	
	addi $11, $11, -1
	j for_cactus_columns
end_cactus_columns:
	addi $10, $10, -1
	
	addi $20, $20, 472
	
	j for_cactus_lines
end_cactus_lines:

	
#################=====game run=============########################
# used: $8, $9, $10, $11, $13, $16, $17, $20, $21, ($22), ($23), $26
game:
	
################=====player-controls======##########################
#used: $8, $9, $13, $16, $17, $20, ($23), $26

player_controls:
	lui $20, 0x1001 #adress start
	addi $20, $20, 15932 #actual adress
       	add $20, $20, $23
       	
       	lui $26, 0xffff 
       	addi $13, $0, ' '
       	addi $16, $0, 'x'
       	
for_player_controls: 
       	
	lw $10, 0($26)
       	beq $10, $0, no_type      
       	lw $16, 4($26)
       	beq $16, $13, type_space
       	beq $16, $16, end
       	                  
       	j no_type 
                                         
type_space:  
	addi $12, $0, 15872 #if parameter loop
	
	addi $8, $0, 17 #player block height
for_player_space_lines:
	beq $8, $0, end_player_space_lines
	
	addi $9, $0, 15 #player block width
for_player_space_columns:
	beq $9, $0, end_player_space_columns
	
   	lw $17, 0x8000($20)
       	sw $17, 0($20)
       	addi $20, $20, -4
       	sw $25, 0($20)
       	
	addi $20, $20, 8
	
	addi $9, $9, -1
	j for_player_space_columns
end_player_space_columns:
	addi $8, $8, -1
	
	addi $20, $20, 452
	
	j for_player_space_lines
end_player_space_lines:
	addi $23, $23, -4
	bne $23, $12, space_next
	addi $23, $0, 0
space_next:	
	j no_type

no_type:

################=====cactus(npc)==========#################################
# used: $10, $11, $20
move_cactus:
	lui $20, 0x1001 #adress start
	add $20, $20, 16856 #actual adress
	add $20, $20, $21
	addi $10, $0, 16 #cactus block height
for_move_cactus_lines:
	beq $10, $0, end_move_cactus_lines
	
	addi $11, $0, 10 #cactus block width
for_move_cactus_columns:
	beq $11, $0, end_move_cactus_columns
	
	lw $24, 0($20)
	lw $25, 0x8000($20)
	sw $25, 0($20)
	addi $20, $20, -4
	sw $24, 0($20)
	
	addi $20, $20, 8

	addi $11, $11, -1
	j for_move_cactus_columns
end_move_cactus_columns:
	addi $10, $10, -1
	
	addi $20, $20, 472
	
	j for_move_cactus_lines
end_move_cactus_lines:
	jal delay
	addi $21, $21, -4
	
	bne $21, -472, move_cactus_next
	addi $21, $0, 0
	addi $9, $0, 16384 #eraser adress
	addi $10, $0, 16 #eraser height
	addi $11, $0, 10 #eraser width
	jal eraser
	j cactus_builder
	
move_cactus_next:
	j game #game loop callback
	
##############========eraser===============###################
# uses: $9 - adress in screen, $10 - height, $11 - width
# used: $7, $8, $9, $10, $11, $12

eraser:
	lui $20, 0x1001
	add $20, $20, $9 # actual adress
	add $10, $0, $10 # eraser height
      	
for_eraser_lines:
	beq $10, $0, end_eraser_lines
	
	add $12, $0, $11 #eraser width
for_eraser_columns:
	beq $12, $0, end_eraser_columns
	
	lw $25, 0x8000($20)
	sw $25, 0($20)
	addi $20, $20, 4
	
	addi $12, $12, -1
	j for_eraser_columns
end_eraser_columns:
	addi $10, $10, -1
	
	addi $20, $20, 472
	
	j for_eraser_lines
end_eraser_lines:
	jr $31
	
#############=========delay===============####################
delay:
	addi $15, $0, 0x0009ff
for_delay:
	beq $15, $0, end_delay
	nop
	addi $15, $15, -1
	j for_delay
end_delay:
	jr $31

#############=======end game===========####################
end: 
	addi $2, $0, 10
	syscall
