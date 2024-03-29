################################################################################
# Name:    Bailey Cheung
################################################################################
##include <iostream>
#using namespace std;
#
#void CoutCstr(char cstr[]);
#void CoutCstrNL(char cstr[]);
#void CoutOneInt(int oneInt);
#void PopulateArray(int a[], int* usedPtr, int cap);
#void ShowArray(int a[], int size);
#void ShowArrayLabeled(int intArr[], int used, char label[]);
#void CopyArray(int dIntArr[], int* dSizePtr, int sIntArr[], int sSize);
#int  ProcArrayL_Aux(int* begPtr, int* endPtr, int* usedPtr);
#void ProcArrayL(int intArr[], int* usedPtr);
#int  RemAllOccur(int intArr[], int used, int target);
#void ProcArrayM(int a1[], int* used1Ptr, int a3[], int* used3Ptr);
#void ProcArrays(int* used3Ptr, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr);
#void ProcArrays(int* used3Ptr, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr);
#
					.text
					.globl main
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int main()
#{
###############################################################################
main:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#             int  a1[12],
#                  a2[12],
#                  a3[12];
#             char reply;
#             int  used1,
#                  used2,
#                  used3;

#             char begA1Str[] = "beginning a1: ";
#             char proA1Str[] = "processed a1: ";
#             char comA2Str[] = "          a2: ";
#             char comA3Str[] = "          a3: ";
#             char dacStr[]   = "Do another case? (n or N = no, others = yes) ";
#             char dlStr[]    = "================================";
#             char byeStr[]   = "bye...";

					# PROLOG:
					addiu $sp, $sp, -336
					sw $ra, 332($sp)
					sw $fp, 328($sp)
					addiu $fp, $sp, 336
					j begDataInitM				# "clutter-reduction" jump
endDataInitM:

					# BODY:
#//           do
begDW_M:#//   {
#                PopulateArray(a1, &used1, 12);
					addi $a0, $sp, 184
					addi $a1, $sp, 180
					li $a2, 12
					jal PopulateArray
#                ShowArrayLabeled(a1, used1, begA1Str);
					addi $a0, $sp, 184
					lw $a1, 180($sp)
					addi $a2, $sp, 24
					jal ShowArrayLabeled
#                ProcArrays(&used3, a1, a2, a3, &used1, &used2);
					addi $a0, $sp, 172	
					addi $a1, $sp, 184
					addi $a2, $sp, 232
					addi $a3, $sp, 280
					
					########## (4) ##########
					addi $t0, $sp, 180
					sw $t0, 16($sp)
					addi $t1, $sp, 176
					sw $t1, 20($sp)
					
					jal ProcArrays
#                ShowArrayLabeled(a1, used1, proA1Str);
					addi $a0, $sp, 184
					lw $a1, 180($sp)
					addi $a2, $sp, 46
					jal ShowArrayLabeled
#                ShowArrayLabeled(a2, used2, comA2Str);
					addi $a0, $sp, 232
					lw $a1, 176($sp)
					addi $a2, $sp, 61
					jal ShowArrayLabeled					
#                ShowArrayLabeled(a3, used3, comA3Str);
					addi $a0, $sp, 280
					lw $a1, 172($sp)
					addi $a2, $sp, 76
					jal ShowArrayLabeled					
#                CoutCstr(dacStr);
					addi $a0, $sp, 91
					jal CoutCstr
#                cin >> reply;
					li $v0, 12
					syscall
					move $t4, $v0				# $t4 is reply					
					# newline to offset shortcoming of syscall #12
					li $v0, 11
					li $a0, '\n'
					syscall
#//           }
DW_MTest:
#             //while (reply != 'n' && reply != 'N');
#             ///if (reply != 'n' && reply != 'N') goto begDW_M;
#             if (reply == 'n') goto xitDW_M;
#             if (reply != 'N') goto begDW_M;
					li $t0, 'n'
					beq $t4, $t0, xitDW_M
					li $t0, 'N'
					bne $t4, $t0, begDW_M
xitDW_M:									# extra helper label

#             CoutCstrNL(dlStr);
					addi $a0, $sp, 137
					jal CoutCstrNL					
#             CoutCstrNL(byeStr);
					addi $a0, $sp, 39
					jal CoutCstrNL					
#             CoutCstrNL(dlStr);
					addi $a0, $sp, 137
					jal CoutCstrNL					
   
					# EPILOG:
					lw $fp, 328($sp)
					lw $ra, 332($sp)
					addiu $sp, $sp, 336
#             return 0;
#}
					li $v0, 10
					syscall

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstr(char cstr[])
#{
###############################################################################
CoutCstr:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
					# PROLOG:
										# no stack frame needed
					# BODY:
#             cout << cstr;
					li $v0, 4
					syscall
					
					# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutCstrNL(char cstr[])
#{
###############################################################################
CoutCstrNL:
#################
# Register usage:
#################
# (usual ones for syscall & function call)
###############################################################################
					# PROLOG:
					addiu $sp, $sp, -32
					sw $ra, 28($sp)
					sw $fp, 24($sp)
					addiu $fp, $sp, 32

					# BODY:
#             CoutCstr(cstr);
					jal CoutCstr
#             cout << '\n';
					li $a0, '\n'
					li $v0, 11
					syscall
					
					# EPILOG:
					lw $fp, 24($sp)
					lw $ra, 28($sp)
					addiu $sp, $sp, 32
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CoutOneInt(int oneInt)
#{
###############################################################################
CoutOneInt:
#################
# Register usage:
#################
# (usual ones for syscall)
###############################################################################
					# PROLOG:
										# no stack frame needed
					# BODY:
#             cout << oneInt;
					li $v0, 1
					syscall
					
					# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void PopulateArray(int intArr[], int* usedPtr, int cap)
#{
###############################################################################
PopulateArray:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: another holder for a value/address
# $t2: yet another holder for a value/address
# $t4: reply
# (usual ones for syscall & function call)
###############################################################################
#             char reply;
#
#             char einStr[]   = "Enter integer #";
#             char moStr[]    = "Max of ";
#             char ieStr[]    = " ints entered...";
#             char emiStr[]   = "Enter more ints? (n or N = no, others = yes) ";

					# PROLOG:
					addiu $sp, $sp, -112
					sw $ra, 108($sp)
					sw $fp, 104($sp)
					addiu $fp, $sp, 112
					j begDataInitPA				# "clutter-reduction" jump
endDataInitPA:
					sw $a0, 0($fp)				# array as received saved in caller's frame
					sw $a1, 4($fp)				# usedPtr as received saved in caller's frame
					sw $a2, 8($fp)				# cap as received saved in caller's frame
					
					# BODY:
#             *usedPtr = 0;
					sw $0, 0($a1)				# $a1 still has usedPtr as received
#//           do
begDW_PA:#//  {
#                CoutCstr(einStr);
					addi $a0, $sp, 16
					jal CoutCstr
#                CoutOneInt(*usedPtr + 1);
					lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
					 					# CoutCstr might have clobbered $a1
					lw $a0, 0($a1)				# $a0 has *usedPtr
					addi $a0, $a0, 1			# *usedPtr + 1 as arg1
					jal CoutOneInt
#                cout << ':' << ' ';
					li $v0, 11
					li $a0, ':'
					syscall
					li $a0, ' '
					syscall
#                cin >> intArr[*usedPtr];
					li $v0, 5					
					syscall					# $v0 has user-entered int
					lw $a0, 0($fp)				# array as received re-loaded into $a0
					lw $a1, 4($fp)				# usedPtr as received re-loaded into $a1
					lw $a2, 8($fp)				# cap as received re-loaded into $a2
										# CoutOneInt might have clobbered $a0, $a1 & $a2
					lw $t1, 0($a1)				# $t1 has *usedPtr
					sll $t2, $t1, 2				# $t2 has (*usedPtr) * 4
					add $t2, $t2, $a0			# $t2 has &array[*usedPtr]
					sw $v0, 0($t2)
#                ++(*usedPtr);
					addi $t1, $t1, 1			# $t1 has *usedPtr + 1
					sw $t1, 0($a1)
#                //if (*usedPtr == cap)
#                if (*usedPtr != cap) goto elseI1_PA;
					bne $t1, $a2, elseI1_PA			# if (*usedPtr != cap) goto Else1
					 					# $t1 still has up-to-date *usedPtr
begI1_PA:#//     {
#                   CoutCstr(moStr);
					addi $a0, $sp, 32
					jal CoutCstr
#                   CoutOneInt(cap);
					lw $a0, 8($fp)				# cap as received loaded into $a0
					 					# not using $a2 as CoutCstr might have clobbered it
					jal CoutOneInt
#                   CoutCstr(ieStr);
					addi $a0, $sp, 86
					jal CoutCstr
#                   cout << endl;
					li $v0, 11
					li $a0, '\n'
					syscall
#                   reply = 'n';
					li $t4, 'n'				# $t4 is reply
#                goto endI1_PA;
					j endI1_PA
#//              }
elseI1_PA:#//    else
#//              {
#                   CoutCstr(emiStr);
					addi $a0, $sp, 40
					jal CoutCstr
#                   cin >> reply;
					li $v0, 12
					syscall
					move $t4, $v0				# $t4 is reply
					# newline to offset shortcoming of syscall #12
					li $v0, 11
					li $a0, '\n'
					syscall
endI1_PA:#//     }
#//           }
#             //while (reply != 'n' && reply != 'N');
#             ///if (reply != 'n' && reply != 'N') goto begDW_PA;
#             if (reply == 'n') goto xitDW_PA;
#             if (reply != 'N') goto begDW_PA;
					li $t0, 'n'
					beq $t4, $t0, xitDW_PA
					li $t0, 'N'
					bne $t4, $t0, begDW_PA
xitDW_PA:									# extra helper label added
#             //if (*usedPtr < cap)
#             if (*usedPtr >= cap) goto endI2_PA;
					bge $t1, $a2, endI2_PA
begI2_PA:#//  {
#                cout << endl;

					#############
					# commented out to avoid unwanted blank line from MARS
					#############
					#li $v0, 11
					#li $a0, '\n'
					#syscall
					#############
endI2_PA:#//  }
					# EPILOG:
					lw $fp, 104($sp)
					lw $ra, 108($sp)
					addiu $sp, $sp, 112  
#             return;
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArray(int intArr[], int used)
#{
###############################################################################
ShowArray:
#################
# Register usage:
#################
# $t1: hopPtr
# $t9: endPtr
# (usual ones for syscall & function call)
###############################################################################
					# PROLOG:
										# no stack frame needed
					sw $a0, 0($sp)				# intArr as received saved in caller's frame
					
					# BODY:
#             int* hopPtr;
#             int* endPtr;
#
#             endPtr = intArr + used - 1;
					addi $t9, $a1, -1			# $t9 has used - 1
					sll $t9, $t9, 2				# $t9 has (used - 1)*4
					add $t9, $t9, $a0			# $t9 has &intArr[used - 1]
#             //for (hopPtr = intArr; hopPtr <= endPtr; ++hopPtr)
#             hopPtr = intArr;
					move $t1, $a0
#             goto F_SATest;
					j F_SATest
begF_SA:#//   {
#                //if (hopPtr == endPtr)
#                if (hopPtr != endPtr) goto elseI_SA;
					bne $t1, $t9, elseI_SA
begI_SA:#//      {
#                   cout << *hopPtr << endl;
					li $v0, 1
					lw $a0, 0($t1)
					syscall
					li $v0, 11
					li $a0, '\n'
					syscall
#                goto endI_SA;
					j endI_SA
#//              }
elseI_SA:#//     else
#//              {
#                   cout << *hopPtr << ' ';
					li $v0, 1
					lw $a0, 0($t1)
					syscall
					li $v0, 11
					li $a0, ' '
					syscall
endI_SA:#//      }
#             ++hopPtr;
					addi $t1, $t1, 4
#                }
endIfSA:
#//           }
F_SATest:
#             if (hopPtr <= endPtr) goto begF_SA;
					ble $t1, $t9, begF_SA
					
					# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ShowArrayLabeled(int intArr[], int used, char label[])
#{
###############################################################################
ShowArrayLabeled:
#################
# Register usage:
#################
# (usual ones for function call)
###############################################################################
					# PROLOG:
					addiu $sp, $sp, -32
					sw $ra, 28($sp)
					sw $fp, 24($sp)
					addiu $fp, $sp, 32
					
					sw $a0, 0($fp)				# array as received saved in caller's frame
					sw $a1, 4($fp)				# used as received saved in caller's frame
					
					# BODY:
#             CoutCstr(label);
					move $a0, $a2
					jal CoutCstr
#             ShowArray(intArr, used);
					lw $a0, 0($fp)				# array as received re-loaded into $a0
					lw $a1, 4($fp)				# used as received re-loaded into $a1
										# CoutCstr might have clobbered $a0 & $a1
					jal ShowArray					
					
					# EPILOG:
					lw $fp, 24($sp)
					lw $ra, 28($sp)
					addiu $sp, $sp, 32  
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void CopyArray(int dIntArr[], int* dSizePtr, int sIntArr[], int sSize)
#{
###############################################################################
CopyArray:
#################
# Register usage:
#################
# $t1: hopPtr1
# $t2: hopPtr2
# $t9: endPtr1
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
					# PROLOG:
										# no stack frame needed
					# BODY:
#             int* hopPtr1;
#             int* hopPtr2;
#             int* endPtr1;
#             *dSizePtr = 0;
#             endPtr1 = sIntArr + sSize;
#             //for (hopPtr1 = sIntArr, hopPtr2 = dIntArr; hopPtr1 < endPtr1; ++hopPtr1, ++hopPtr2)
#             hopPtr1 = sIntArr;
#             hopPtr2 = dIntArr;
#             goto F_CATest;
					sw $zero, 0($a1)
					sll $v1, $a3, 2
					add $t9, $a2, $v1
					
					move $t1, $a2
					move $t2, $a0
					j F_CATest
begF_CA:#//   {
#                *hopPtr2 = *hopPtr1;
#                ++(*dSizePtr);
#(SAME AS)       *dSizePtr = *dSizePtr + 1;
#             ++hopPtr1;
#             ++hopPtr2;
#//           }
					lw $t3, 0($t1)
					sw $t3, 0($t2)
					
					lw $t4, 0($a1)
					addi $t4, $t4, 4
					sw $t4, 0($a1)
					
					addi $t1, $t1, 4
					addi $t2, $t2, 4
F_CATest:
#             if (hopPtr1 < endPtr1) goto begF_CA;
					blt $t1, $t9, begF_CA
					########## (14) ##########
					
					# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int  ProcArrayL_Aux(int* begPtr, int* endPtr, int* usedPtr)
#{
###############################################################################
ProcArrayL_Aux:
#################
# Register usage:
#################
# $s2: anchor
# $t2: hopPtr22
# $t3: hopPtr222
# $v0: remCount (value to be returned)
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
					# PROLOG:
					addiu $sp, $sp, -32
					sw $ra, 28($sp)
					sw $fp, 24($sp)
					addiu $fp, $sp, 32
#             int* hopPtr22;
#             int* hopPtr222;
#             int anchor;
#             int remCount;

#             anchor = (*begPtr);
#             remCount = 0;
#             //for (hopPtr22 = begPtr + 1; hopPtr22 < endPtr; ++hopPtr22)
#             hopPtr22 = begPtr + 1;
#             goto F1_PALATest;
					#BODY
					lw $t4, 0($a0)
					move $s2, $t4
					li $v0, 0
					lw $t5, 0($a0)
					addi $t5, $t5, 4 
					move $t2, $t5
					j F1_PALATest

begF1_PALA:#//{
#                //if (*hopPtr22 == anchor)
#                if (*hopPtr22 != anchor) goto endI_PALA;
					lw $t6, 0($t2)
					bne $t6, $s2, endI_PALA
begI_PALA:#//    {
#                   //for (hopPtr222 = hopPtr22 + 1; hopPtr222 < endPtr; ++hopPtr222)
#                   hopPtr222 = hopPtr22 + 1;
#                   goto F2_PALATest;
					addi $t3, $t2, 4
					j F2_PALATest
begF2_PALA:#//      {
#                      *(hopPtr222 - 1) = *hopPtr222;
#                   ++hopPtr222;
#//                 }
					lw $t7, 0($t3)
					sw $t7, -4($t3)
					addi $t3, $t3, 4
F2_PALATest:
#                   if (hopPtr222 < endPtr) goto begF2_PALA;
#
#                   --(*usedPtr);
#(SAME AS)       *usedPtr = *usedPtr - 1;
#                   --endPtr;
#                   --hopPtr22;
#                   ++remCount;
					blt $t3, $a1, begF2_PALA
					lw $t8, -4($a2)
					sw $t8, 0($a2)
					addi $a1, $a1, -4
					addi $t2, $t2, -4
					addi $v0, $v0, 1
	
endI_PALA:#//    }
#             ++hopPtr22;
#//           }
					addi $t2, $t2, 4
F1_PALATest:
#             if (hopPtr22 < endPtr) goto begF1_PALA;
					blt $t2, $a1, begF1_PALA
					
					# EPILOG:
					sw $s2, 0($sp)
					lw $fp, 24($sp)
					lw $ra, 28($sp)
					addiu $sp, $sp, 32				
					########## (29) ##########

#             return remCount;
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
#			li $v0, 999999999					# don't want to clobber return value
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArrayL(int intArr[], int* usedPtr)
#{
###############################################################################
ProcArrayL:
#################
# Register usage:
#################
# $s2: endPtr2
# $t2: hopPtr2
# $v0: remCount (return value of call to ProcArrayL_Aux)
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################

					# PROLOG:
					addiu $sp, $sp, -40
					sw $ra, 36($sp)
					sw $fp, 32($sp)
					addiu $fp, $sp, 40
					
					sw $a0, 0($fp)
					sw $a1, 4($fp)
					
					# BODY:
#             int* hopPtr2;
#             int* endPtr2;
#             int remCount;
             
#             endPtr2 = intArr + (*usedPtr);
#             //for (hopPtr2 = intArr; hopPtr2 < endPtr2; ++hopPtr2)
#             hopPtr2 = intArr;
#             goto F_PALTest;
					lw $t3, 0($a1)
					sll $t3, $t3, 2
					add $s2, $a0, $t3
					move $t2, $a0
		
					j F_PALTest
begF_PAL:#//  {
#                remCount = ProcArrayL_Aux(hopPtr2, endPtr2, usedPtr);
#                //if (remCount != 0)
#                if (remCount == 0) goto endI_PAL;
					move $a2, $a1,
					move $a0, $t2
					move $a1, $s2
					jal ProcArrayL_Aux
					beqz $v0, endI_PAL
begI_PAL:#//     {
#                   --hopPtr2;
#                   endPtr2 -= remCount;
					addi $t2, $t2, -4
					sub $s2, $s2, $v0
endI_PAL:#//     }
#             ++hopPtr2;
#//           }
					addi $t2, $t2, 4
F_PALTest:
#             if (hopPtr2 < endPtr2) goto begF_PAL;
					blt $t2, $s2, begF_PAL
					
					# EPILOG:
					sw $s2, 16($sp)
					sw $t2, 24($sp)
					sw $a0, 0($sp)
					sw $a1, 4($sp)
					
					lw $fp, 32($sp)
					lw $ra, 36($sp)					
				
					########## (27) ##########

#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#int  RemAllOccur(int* begPtr, int* endPtr, int target)
#{
###############################################################################
RemAllOccur:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr
# $v0: remCount (value to be returned)
# $v1: another holder for a value/address
# (usual ones for function call)
###############################################################################
					# PROLOG:
										# no stack frame needed
					# BODY:
#             int remCount;
#             int* hopPtr;

#             remCount = 0;
#             //for (hopPtr = begPtr; hopPtr < endPtr; ++hopPtr)
#             hopPtr = begPtr; 
#             goto F_RAOTest;
					li $v0, 0 
					move $t1, $a0
					j F_RAOTest
begF_RAO:#//  {
#                //if (*hopPtr == target)
#                if (*hopPtr != target) goto elseI_RAO;
					lw $t2, 0($t1)
					bne $t2, $a2, elseI_RAO
begI_RAO:#//     {
#                   ++remCount;
#                goto endI_RAO;
#//              }
					addi $v0, $v0, 1
					j endI_RAO
elseI_RAO:#//    else
#//              {
#                   *(hopPtr - remCount) = (*hopPtr);
					lw $t3, 0($t1)
					sll $t4, $v0, 2
					sub $t1, $t1, $t4
					sw $t3, 0($t1)
endI_RAO:#//     }
#             ++hopPtr;
#//           }
					addi $t1, $t1, 4 
F_RAOTest:
#             if (hopPtr < endPtr) goto begF_RAO;
					blt $t1, $a1, begF_RAO 
					
					########## (13) ##########	

					

#             return remCount;
					# EPILOG:
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
#			li $v0, 999999999					# don't want to clobber return value
			li $v1, 999999999
#########################################
					jr $ra
#}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArrayM(int a1[], int* used1Ptr, int a3[], int* used3Ptr)
#{
###############################################################################
ProcArrayM:
#################
# Register usage:
#################
# $t0: holder for a value/address
# $t1: hopPtr1
# $t3: another holder for a value/address
# $t9: endPtr1
# $v0: remCount (return value of call to RemAllOccur)
# $v1: yet another holder for a value/address
# (usual ones for function call)
###############################################################################
					# PROLOG:
					addiu $sp, $sp, -32
					sw $ra, 28($sp)
					sw $fp, 24($sp)
					addiu $fp, $sp, 32
					
					sw $a0, 0($fp)
					sw $a1, 4($fp)
					sw $a2, 8($fp)
					sw $a3, 12($fp)
					
					# BODY:
#             int remCount;
#             int* hopPtr1;
#             int* endPtr1;

#             *used3Ptr = 0;
#             hopPtr1 = a1;
#             endPtr1 = a1 + (*used1Ptr);
#             //while (hopPtr1 < endPtr1)
#             goto W_PAMTest;
					move $t1, $a0
					lw $t4, 0($a1)
					sll $t4, $t4, 2
					add $t9, $a0, $t4
					j W_PAMTest
begW_PAM:#//  {
#                *(a3 + *used3Ptr) = *hopPtr1;
#                ++(*used3Ptr);
#                remCount = RemAllOccur(hopPtr1 + 1, endPtr1, *hopPtr1);
#                *used1Ptr -= remCount;
#(SAME AS)       *used1Ptr = *used1Ptr - remCount;
#                endPtr1 -= remCount;
#                ++hopPtr1;
#//           }
					lw $t5, 0($a3)
					sll $t5, $t5, 2
					add $a2, $a2, $t5
					
					lw $t6, 0($t1)
					sw $t6, 0($a2)
					lw $t7, 0($a3)
					addi $t7, $t7, 4
					
					sw $t7, 0($a3)
					addi $a0, $t1, 4
					
					move $a1, $t9
					lw $a2, 0($t1)
					jal RemAllOccur
					
					lw $a0, 0($fp)
					lw $a1, 4($fp)
					lw $a2, 8($fp)
					lw $a3, 12($fp)
					
					lw $t4, 0($a1)
					sub $t4, $t4, $v0
					sw $t4, 0($a1)
					
					sll $v0, $v0, 2
					sub $t9, $t9, $v0
					addi $t1, $t1, 4
					
#             if (hopPtr1 < endPtr1) goto begW_PAM;
W_PAMTest:				blt $t1, $t9, begW_PAM
					
					# EPILOG:
					lw $fp, 24($sp)
					lw $ra, 28($sp)
					addiu $sp, $sp, 32 
					
					########## (44) ##########

#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#void ProcArrays(int* used3Ptr, int a1[], int a2[], int a3[], int* used1Ptr, int* used2Ptr)
#{
###############################################################################
ProcArrays:
#################
# Register usage:
#################
# $t1: i
# $v1: holder for a value/address
# (usual ones for function call)
###############################################################################
					# PROLOG:
					addiu $sp, $sp, -32
					sw $ra, 28($sp)
					sw $fp, 24($sp)
					addiu $fp, $sp, 32
					
					sw $a0, 0($fp)				# used3Ptr as received saved in caller's frame
					sw $a1, 4($fp)				# a1 as received saved in caller's frame
					sw $a2, 8($fp)				# a2 as received saved in caller's frame
					sw $a3, 12($fp)				# a3 as received saved in caller's frame
					
					# BODY:
#   CopyArray(a2, used2Ptr, a1, *used1Ptr);
					move $a0, $a2				# a2 as arg1 ($a2 is still as received)
					move $a2, $a1				# a1 as arg3 ($a1 is still as received)
					
					########## (3) ##########		#finished
					lw $a1, 20($fp)
					lw $v1, 16($sp)
					lw $a3, 0($v1) 		
					
					jal CopyArray
					#j begDebugShowA2_CA			# uncomment this instruction if useful when debugging 
endDebugShowA2_CA:					
#   ProcArrayL(a2, used2Ptr);
					
					########## (2) ##########	#working 
					lw $a0, 8($fp)
					addi $a1, $sp, 176
					
					jal ProcArrayL
					#j begDebugShowA2_PAL			# uncomment this instruction if useful when debugging
endDebugShowA2_PAL:					
#   ProcArrayM(a1, used1Ptr, a3, used3Ptr);
					
					########## (4) ##########	#finished
					lw $a0, 4($fp)
					addi $a1, $sp, 180
					lw $a2, 12($fp)
					lw $a3, 0($sp)
					
					jal ProcArrayM
					#j begDebugShowA1A2_PAM			# uncomment this instruction if useful when debugging
endDebugShowA1A2_PAM:					
					# EPILOG:
					lw $fp, 24($sp)				
					lw $ra, 28($sp)
					addiu $sp, $sp, 32  
#}
#########################################
# deliberate clobbering of caller-saved
# (meant to catch improper presumptions -
# no effect if no such presumptions made)
#########################################
			li $a0, 999999999
			li $a1, 999999999
			li $a2, 999999999
			li $a3, 999999999
			li $t0, 999999999
			li $t1, 999999999
			li $t2, 999999999
			li $t3, 999999999
			li $t4, 999999999
			li $t5, 999999999
			li $t6, 999999999
			li $t7, 999999999
			li $t8, 999999999
			li $t9, 999999999
			li $v0, 999999999
			li $v1, 999999999
#########################################
					jr $ra

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitM:
					li $t0, 'b'
					sb $t0, 24($sp)
					li $t0, 'e'
					sb $t0, 25($sp)
					li $t0, 'g'
					sb $t0, 26($sp)
					li $t0, 'i'
					sb $t0, 27($sp)
					li $t0, 'n'
					sb $t0, 28($sp)
					li $t0, 'n'
					sb $t0, 29($sp)
					li $t0, 'i'
					sb $t0, 30($sp)
					li $t0, 'n'
					sb $t0, 31($sp)
					li $t0, 'g'
					sb $t0, 32($sp)
					li $t0, ' '
					sb $t0, 33($sp)
					li $t0, 'a'
					sb $t0, 34($sp)
					li $t0, '1'
					sb $t0, 35($sp)
					li $t0, ':'
					sb $t0, 36($sp)
					li $t0, ' '
					sb $t0, 37($sp)
					li $t0, '\0'
					sb $t0, 38($sp)
					li $t0, 'b'
					sb $t0, 39($sp)
					li $t0, 'y'
					sb $t0, 40($sp)
					li $t0, 'e'
					sb $t0, 41($sp)
					li $t0, '.'
					sb $t0, 42($sp)
					li $t0, '.'
					sb $t0, 43($sp)
					li $t0, '.'
					sb $t0, 44($sp)
					li $t0, '\0'
					sb $t0, 45($sp)
					li $t0, 'p'
					sb $t0, 46($sp)
					li $t0, 'r'
					sb $t0, 47($sp)
					li $t0, 'o'
					sb $t0, 48($sp)
					li $t0, 'c'
					sb $t0, 49($sp)
					li $t0, 'e'
					sb $t0, 50($sp)
					li $t0, 's'
					sb $t0, 51($sp)
					li $t0, 's'
					sb $t0, 52($sp)
					li $t0, 'e'
					sb $t0, 53($sp)
					li $t0, 'd'
					sb $t0, 54($sp)
					li $t0, ' '
					sb $t0, 55($sp)
					li $t0, 'a'
					sb $t0, 56($sp)
					li $t0, '1'
					sb $t0, 57($sp)
					li $t0, ':'
					sb $t0, 58($sp)
					li $t0, ' '
					sb $t0, 59($sp)
					li $t0, '\0'
					sb $t0, 60($sp)
					li $t0, ' '
					sb $t0, 61($sp)
					li $t0, ' '
					sb $t0, 62($sp)
					li $t0, ' '
					sb $t0, 63($sp)
					li $t0, ' '
					sb $t0, 64($sp)
					li $t0, ' '
					sb $t0, 65($sp)
					li $t0, ' '
					sb $t0, 66($sp)
					li $t0, ' '
					sb $t0, 67($sp)
					li $t0, ' '
					sb $t0, 68($sp)
					li $t0, ' '
					sb $t0, 69($sp)
					li $t0, ' '
					sb $t0, 70($sp)
					li $t0, 'a'
					sb $t0, 71($sp)
					li $t0, '2'
					sb $t0, 72($sp)
					li $t0, ':'
					sb $t0, 73($sp)
					li $t0, ' '
					sb $t0, 74($sp)
					li $t0, '\0'
					sb $t0, 75($sp)
					li $t0, ' '
					sb $t0, 76($sp)
					li $t0, ' '
					sb $t0, 77($sp)
					li $t0, ' '
					sb $t0, 78($sp)
					li $t0, ' '
					sb $t0, 79($sp)
					li $t0, ' '
					sb $t0, 80($sp)
					li $t0, ' '
					sb $t0, 81($sp)
					li $t0, ' '
					sb $t0, 82($sp)
					li $t0, ' '
					sb $t0, 83($sp)
					li $t0, ' '
					sb $t0, 84($sp)
					li $t0, ' '
					sb $t0, 85($sp)
					li $t0, 'a'
					sb $t0, 86($sp)
					li $t0, '3'
					sb $t0, 87($sp)
					li $t0, ':'
					sb $t0, 88($sp)
					li $t0, ' '
					sb $t0, 89($sp)
					li $t0, '\0'
					sb $t0, 90($sp)
					li $t0, 'D'
					sb $t0, 91($sp)
					li $t0, 'o'
					sb $t0, 92($sp)
					li $t0, ' '
					sb $t0, 93($sp)
					li $t0, 'a'
					sb $t0, 94($sp)
					li $t0, 'n'
					sb $t0, 95($sp)
					li $t0, 'o'
					sb $t0, 96($sp)
					li $t0, 't'
					sb $t0, 97($sp)
					li $t0, 'h'
					sb $t0, 98($sp)
					li $t0, 'e'
					sb $t0, 99($sp)
					li $t0, 'r'
					sb $t0, 100($sp)
					li $t0, ' '
					sb $t0, 101($sp)
					li $t0, 'c'
					sb $t0, 102($sp)
					li $t0, 'a'
					sb $t0, 103($sp)
					li $t0, 's'
					sb $t0, 104($sp)
					li $t0, 'e'
					sb $t0, 105($sp)
					li $t0, '?'
					sb $t0, 106($sp)
					li $t0, ' '
					sb $t0, 107($sp)
					li $t0, '('
					sb $t0, 108($sp)
					li $t0, 'n'
					sb $t0, 109($sp)
					li $t0, ' '
					sb $t0, 110($sp)
					li $t0, 'o'
					sb $t0, 111($sp)
					li $t0, 'r'
					sb $t0, 112($sp)
					li $t0, ' '
					sb $t0, 113($sp)
					li $t0, 'N'
					sb $t0, 114($sp)
					li $t0, ' '
					sb $t0, 115($sp)
					li $t0, '='
					sb $t0, 116($sp)
					li $t0, ' '
					sb $t0, 117($sp)
					li $t0, 'n'
					sb $t0, 118($sp)
					li $t0, 'o'
					sb $t0, 119($sp)
					li $t0, ','
					sb $t0, 120($sp)
					li $t0, ' '
					sb $t0, 121($sp)
					li $t0, 'o'
					sb $t0, 122($sp)
					li $t0, 't'
					sb $t0, 123($sp)
					li $t0, 'h'
					sb $t0, 124($sp)
					li $t0, 'e'
					sb $t0, 125($sp)
					li $t0, 'r'
					sb $t0, 126($sp)
					li $t0, 's'
					sb $t0, 127($sp)
					li $t0, ' '
					sb $t0, 128($sp)
					li $t0, '='
					sb $t0, 129($sp)
					li $t0, ' '
					sb $t0, 130($sp)
					li $t0, 'y'
					sb $t0, 131($sp)
					li $t0, 'e'
					sb $t0, 132($sp)
					li $t0, 's'
					sb $t0, 133($sp)
					li $t0, ')'
					sb $t0, 134($sp)
					li $t0, ' '
					sb $t0, 135($sp)
					li $t0, '\0'
					sb $t0, 136($sp)
					li $t0, '='
					sb $t0, 137($sp)
					li $t0, '='
					sb $t0, 138($sp)
					li $t0, '='
					sb $t0, 139($sp)
					li $t0, '='
					sb $t0, 140($sp)
					li $t0, '='
					sb $t0, 141($sp)
					li $t0, '='
					sb $t0, 142($sp)
					li $t0, '='
					sb $t0, 143($sp)
					li $t0, '='
					sb $t0, 144($sp)
					li $t0, '='
					sb $t0, 145($sp)
					li $t0, '='
					sb $t0, 146($sp)
					li $t0, '='
					sb $t0, 147($sp)
					li $t0, '='
					sb $t0, 148($sp)
					li $t0, '='
					sb $t0, 149($sp)
					li $t0, '='
					sb $t0, 150($sp)
					li $t0, '='
					sb $t0, 151($sp)
					li $t0, '='
					sb $t0, 152($sp)
					li $t0, '='
					sb $t0, 153($sp)
					li $t0, '='
					sb $t0, 154($sp)
					li $t0, '='
					sb $t0, 155($sp)
					li $t0, '='
					sb $t0, 156($sp)
					li $t0, '='
					sb $t0, 157($sp)
					li $t0, '='
					sb $t0, 158($sp)
					li $t0, '='
					sb $t0, 159($sp)
					li $t0, '='
					sb $t0, 160($sp)
					li $t0, '='
					sb $t0, 161($sp)
					li $t0, '='
					sb $t0, 162($sp)
					li $t0, '='
					sb $t0, 163($sp)
					li $t0, '='
					sb $t0, 164($sp)
					li $t0, '='
					sb $t0, 165($sp)
					li $t0, '='
					sb $t0, 166($sp)
					li $t0, '='
					sb $t0, 167($sp)
					li $t0, '='
					sb $t0, 168($sp)
					li $t0, '\0'
					sb $t0, 169($sp)
					j endDataInitM				# back to main

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# PopulateArray's string initialization code moved out of the way to reduce clutter
###############################################################################
begDataInitPA:
					li $t0, 'E'
					sb $t0, 16($sp)
					li $t0, 'n'
					sb $t0, 17($sp)
					li $t0, 't'
					sb $t0, 18($sp)
					li $t0, 'e'
					sb $t0, 19($sp)
					li $t0, 'r'
					sb $t0, 20($sp)
					li $t0, ' '
					sb $t0, 21($sp)
					li $t0, 'i'
					sb $t0, 22($sp)
					li $t0, 'n'
					sb $t0, 23($sp)
					li $t0, 't'
					sb $t0, 24($sp)
					li $t0, 'e'
					sb $t0, 25($sp)
					li $t0, 'g'
					sb $t0, 26($sp)
					li $t0, 'e'
					sb $t0, 27($sp)
					li $t0, 'r'
					sb $t0, 28($sp)
					li $t0, ' '
					sb $t0, 29($sp)
					li $t0, '#'
					sb $t0, 30($sp)
					li $t0, '\0'
					sb $t0, 31($sp)
					li $t0, 'M'
					sb $t0, 32($sp)
					li $t0, 'a'
					sb $t0, 33($sp)
					li $t0, 'x'
					sb $t0, 34($sp)
					li $t0, ' '
					sb $t0, 35($sp)
					li $t0, 'o'
					sb $t0, 36($sp)
					li $t0, 'f'
					sb $t0, 37($sp)
					li $t0, ' '
					sb $t0, 38($sp)
					li $t0, '\0'
					sb $t0, 39($sp)
					li $t0, 'E'
					sb $t0, 40($sp)
					li $t0, 'n'
					sb $t0, 41($sp)
					li $t0, 't'
					sb $t0, 42($sp)
					li $t0, 'e'
					sb $t0, 43($sp)
					li $t0, 'r'
					sb $t0, 44($sp)
					li $t0, ' '
					sb $t0, 45($sp)
					li $t0, 'm'
					sb $t0, 46($sp)
					li $t0, 'o'
					sb $t0, 47($sp)
					li $t0, 'r'
					sb $t0, 48($sp)
					li $t0, 'e'
					sb $t0, 49($sp)
					li $t0, ' '
					sb $t0, 50($sp)
					li $t0, 'i'
					sb $t0, 51($sp)
					li $t0, 'n'
					sb $t0, 52($sp)
					li $t0, 't'
					sb $t0, 53($sp)
					li $t0, 's'
					sb $t0, 54($sp)
					li $t0, '?'
					sb $t0, 55($sp)
					li $t0, ' '
					sb $t0, 56($sp)
					li $t0, '('
					sb $t0, 57($sp)
					li $t0, 'n'
					sb $t0, 58($sp)
					li $t0, ' '
					sb $t0, 59($sp)
					li $t0, 'o'
					sb $t0, 60($sp)
					li $t0, 'r'
					sb $t0, 61($sp)
					li $t0, ' '
					sb $t0, 62($sp)
					li $t0, 'N'
					sb $t0, 63($sp)
					li $t0, ' '
					sb $t0, 64($sp)
					li $t0, '='
					sb $t0, 65($sp)
					li $t0, ' '
					sb $t0, 66($sp)
					li $t0, 'n'
					sb $t0, 67($sp)
					li $t0, 'o'
					sb $t0, 68($sp)
					li $t0, ','
					sb $t0, 69($sp)
					li $t0, ' '
					sb $t0, 70($sp)
					li $t0, 'o'
					sb $t0, 71($sp)
					li $t0, 't'
					sb $t0, 72($sp)
					li $t0, 'h'
					sb $t0, 73($sp)
					li $t0, 'e'
					sb $t0, 74($sp)
					li $t0, 'r'
					sb $t0, 75($sp)
					li $t0, 's'
					sb $t0, 76($sp)
					li $t0, ' '
					sb $t0, 77($sp)
					li $t0, '='
					sb $t0, 78($sp)
					li $t0, ' '
					sb $t0, 79($sp)
					li $t0, 'y'
					sb $t0, 80($sp)
					li $t0, 'e'
					sb $t0, 81($sp)
					li $t0, 's'
					sb $t0, 82($sp)
					li $t0, ')'
					sb $t0, 83($sp)
					li $t0, ' '
					sb $t0, 84($sp)
					li $t0, '\0'
					sb $t0, 85($sp)
					li $t0, ' '
					sb $t0, 86($sp)
					li $t0, 'i'
					sb $t0, 87($sp)
					li $t0, 'n'
					sb $t0, 88($sp)
					li $t0, 't'
					sb $t0, 89($sp)
					li $t0, 's'
					sb $t0, 90($sp)
					li $t0, ' '
					sb $t0, 91($sp)
					li $t0, 'e'
					sb $t0, 92($sp)
					li $t0, 'n'
					sb $t0, 93($sp)
					li $t0, 't'
					sb $t0, 94($sp)
					li $t0, 'e'
					sb $t0, 95($sp)
					li $t0, 'r'
					sb $t0, 96($sp)
					li $t0, 'e'
					sb $t0, 97($sp)
					li $t0, 'd'
					sb $t0, 98($sp)
					li $t0, '.'
					sb $t0, 99($sp)
					li $t0, '.'
					sb $t0, 100($sp)
					li $t0, '.'
					sb $t0, 101($sp)
					li $t0, '\0'
					sb $t0, 102($sp)
					j endDataInitPA				# back to PopulateArray

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
###################### code for used during debugging #########################
###################### show a2 after calling CopyArray ########################
begDebugShowA2_CA:
					li $v0, 11
					li $a0, '*'
					syscall
					syscall
					syscall
					syscall
					syscall
					syscall
					syscall
					li $a0, 'a'
					syscall
					li $a0, '2'
					syscall
					li $a0, '@'
					syscall
					li $a0, 'C'
					syscall
					li $a0, 'A'
					syscall
					li $a0, ':'
					syscall
					li $a0, ' '
					syscall
					lw $a0, 8($fp)				# a2 as received (saved on stack coming in) as arg1
					lw $a1, 20($fp)				# $a1 loaded w/ used2Ptr as received (via stack)
					lw $a1, 0($a1)				# *used2Ptr as arg2 
					jal ShowArray
					j endDebugShowA2_CA			# back to ProcArrays

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
###################### code for used during debugging #########################
###################### show a2 after calling ProcArrayL #######################
begDebugShowA2_PAL:
					li $v0, 11
					li $a0, '*'
					syscall
					syscall
					syscall
					syscall
					syscall
					syscall
					li $a0, 'a'
					syscall
					li $a0, '2'
					syscall
					li $a0, '@'
					syscall
					li $a0, 'P'
					syscall
					li $a0, 'A'
					syscall
					li $a0, 'L'
					syscall
					li $a0, ':'
					syscall
					li $a0, ' '
					syscall
					lw $a0, 8($fp)				# a2 as received (saved on stack coming in) as arg1
					lw $a1, 20($fp)				# $a1 loaded w/ used2Ptr as received (via stack)
					lw $a1, 0($a1)				# *used2Ptr as arg2 
					jal ShowArray
					j endDebugShowA2_PAL			# back to ProcArrays

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#################### code for used during debugging ###########################
#################### show a1 & a3 after calling ProcArrayM ####################
begDebugShowA1A2_PAM:
					li $v0, 11
					li $a0, '*'
					syscall
					syscall
					syscall
					syscall
					syscall
					syscall
					li $a0, 'a'
					syscall
					li $a0, '1'
					syscall
					li $a0, '@'
					syscall
					li $a0, 'P'
					syscall
					li $a0, 'A'
					syscall
					li $a0, 'M'
					syscall
					li $a0, ':'
					syscall
					li $a0, ' '
					syscall
					lw $a0, 4($fp)				# a1 as received (saved on stack coming in) as arg1
					lw $a1, 16($fp)				# $a1 loaded w/ used1Ptr as received (via stack)
					lw $a1, 0($a1)				# *used1Ptr as arg2 
					jal ShowArray
					li $v0, 11
					li $a0, '*'
					syscall
					syscall
					syscall
					syscall
					syscall
					syscall
					li $a0, 'a'
					syscall
					li $a0, '3'
					syscall
					li $a0, '@'
					syscall
					li $a0, 'P'
					syscall
					li $a0, 'A'
					syscall
					li $a0, 'M'
					syscall
					li $a0, ':'
					syscall
					li $a0, ' '
					syscall
					lw $a0, 12($fp)				# a3 as received (saved on stack coming in) as arg1
					lw $a1, 0($fp)				# $a1 loaded w/ used3Ptr as received (saved on stack coming in)
					lw $a1, 0($a1)				# *used3Ptr as arg2 
					jal ShowArray
					j endDebugShowA1A2_PAM			# back to ProcArrays

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
########################### Sample Test Run Result ############################
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1
# processed a1: 1
#           a2: 1
#           a3: 1
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #2: 2
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1 2
# processed a1: 1 2
#           a2: 1 2
#           a3: 1 2
# Do another case? (n or N = no, others = yes) y 
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #2: 1
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1 1
# processed a1: 1
#           a2: 1
#           a3: 1
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #2: 2
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #3: 3
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1 2 3
# processed a1: 1 2 3
#           a2: 1 2 3
#           a3: 1 2 3
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #2: 2
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #3: 2
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1 2 2
# processed a1: 1 2
#           a2: 1 2
#           a3: 1 2
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #2: 1
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #3: 1
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 1 1 1
# processed a1: 1
#           a2: 1
#           a3: 1
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 3
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #2: 3
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #3: 3
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #4: 2
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #5: 2
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #6: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #7: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #8: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #9: 4
# Enter more ints? (n or N = no, others = yes) n
# beginning a1: 3 3 3 2 2 4 4 4 4
# processed a1: 3 2 4
#           a2: 3 2 4
#           a3: 3 2 4
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #2: 1
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #3: 1
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #4: 2
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #5: 2
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #6: 2
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #7: 3
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #8: 3
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #9: 3
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #10: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #11: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #12: 4
# Max of 12 ints entered...
# beginning a1: 1 1 1 2 2 2 3 3 3 4 4 4
# processed a1: 1 2 3 4
#           a2: 1 2 3 4
#           a3: 1 2 3 4
# Do another case? (n or N = no, others = yes) y
# Enter integer #1: 1
# Enter more ints? (n or N = no, others = yes) 5
# Enter integer #2: 5
# Enter more ints? (n or N = no, others = yes) 1
# Enter integer #3: 1
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #4: 2
# Enter more ints? (n or N = no, others = yes) 2
# Enter integer #5: 2
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #6: 4
# Enter more ints? (n or N = no, others = yes) 5
# Enter integer #7: 5
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #8: 3
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #9: 4
# Enter more ints? (n or N = no, others = yes) 3
# Enter integer #10: 3
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #11: 4
# Enter more ints? (n or N = no, others = yes) 4
# Enter integer #12: 4
# Max of 12 ints entered...
# beginning a1: 1 5 1 2 2 4 5 3 4 3 4 4
# processed a1: 1 5 2 4 3
#           a2: 1 5 2 4 3
#           a3: 1 5 2 4 3
# Do another case? (n or N = no, others = yes) 
# ================================
# bye...
# ================================
######################### End Sample Test Run Result ##########################
