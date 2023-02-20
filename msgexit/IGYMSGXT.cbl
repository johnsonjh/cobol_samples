      ******************************************************************
      *  IGYMSGXT - Sample COBOL program for MSGEXIT                   *
      ******************************************************************
      *                                                                *
      *  COBOL for AIX                                                 *
      *               Version 4 Release 1 Modification 0               *
      *                                                                *
      *#################################################################
      *#                                                               #
      *#  Licensed Materials - Property of IBM.                        #
      *#  5724-Z87 © COPYRIGHT IBM CORP. 2010                          #
      *#  All Rights Reserved.                                         #
      *#  US Government Users Restricted Rights -                      #
      *#  Use, duplication or disclosure restricted by                 #
      *#  GSA ADP Schedule Contract with IBM Corp.                     #
      *#                                                               #
      *#  This file contains sample code.  You may copy, modify, and   #
      *#  distribute these samples, or their modifications, in any     #
      *#  form, internally or as part of Your application or related   #
      *#  documentation. These samples have not been tested under all  #
      *#  conditions and are provided to You by IBM without obligation #
      *#  of support of any kind. IBM PROVIDES THESE SAMPLES "AS IS"   #
      *#  SUBJECT TO ANY STATUTORY WARRANTIES THAT CANNOT BE EXCLUDED. #
      *#  IBM MAKES NO WARRANTIES OR CONDITIONS, EITHER EXPRESS OR     #
      *#  IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES#
      *#  OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR   #
      *#  PURPOSE, AND NON-INFRINGEMENT REGARDING THESE SAMPLES OR     #
      *#  TECHNICAL SUPPORT, IF ANY. You will indemnify IBM or third   #
      *#  parties that provide IBM products ("Third Parties") from and #
      *#  against any third party claim arising out of the use,        #
      *#  modification or distribution of these samples with Your      #
      *#  application. You may not use the same path name as the       #
      *#  original files/modules. You must not alter or delete any     #
      *#  copyright information in the Samples.                        #
      *#                                                               #
      *#################################################################

      *****************************************************************
      *  Function:  This is a SAMPLE user exit for the MSGEXIT        *
      *             suboption of the EXIT compiler option.  This exit *
      *             can be used to customize the severity of or       *
      *             suppress compiler diagnostic messages and FIPS    *
      *             messages.  This example program includes several  *
      *             sample customizations to show how customizations  *
      *             are done.  Feel free to change the customizations *
      *             as appropriate to meet your requirements.         *
      *                                                               *
      *---------------------------------------------------------------*
      *  COMPILE NOTE:  IBM recommends that you not use program names *
      *                 that start with IGY, so first rename it.      *
      *                 In this example, we use the name MYEXIT.      *
      *                                                               *
      *                 To prepare a compiler user exit in COBOL,     *
      *                 it should be a shared library module:         *
      *   cob2 -o -qNOEXIT -q32 MYEXIT myexit.cbl -be MYEXIT -bM:SRE  *
      *                                                               *
      *  USAGE NOTE:  The compiler needs to have access to MYEXIT at  *
      *               compile time, so set LIBPATH accordingly:       *
      *                                                               *
      *   EX:       export LIBPATH=/u1/cobdev/exits:$LIBPATH          *
      *                                                               *
      *               (This assumes the shared object is in           *
      *                 /u1/cobdev/exits )                            *
      *                                                               *
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  IGYMSGXT.
       DATA DIVISION.

         WORKING-STORAGE SECTION.

      *****************************************************************
      *                                                               *
      *   Local variables.                                            *
      *                                                               *
      *****************************************************************

          77 EXIT-TYPEN            PIC 9(4).
          77 EXIT-DEFAULT-SEV-FIPS PIC X.

      *****************************************************************
      *                                                               *
      *   Definition of the User-Exit Parameter List, which is        *
      *   passed from the COBOL compiler to the user-exit module.     *
      *                                                               *
      *****************************************************************

         LINKAGE SECTION.
          01 UXPARM.
             02 EXIT-TYPE        PIC 9(4)   COMP.
             02 EXIT-OPERATION   PIC 9(4)   COMP.
             02 EXIT-RETURNCODE  PIC 9(9)   COMP.
             02 EXIT-DATALENGTH  PIC 9(9)   COMP.
             02 EXIT-DATA        POINTER.
             02 EXIT-WORK-AREA.
                03 EXIT-WORK-AREA-PTR  OCCURS 4  POINTER.
             02 EXIT-TEXT-NAME   POINTER.
             02 EXIT-PARMS       POINTER.
             02 EXIT-LINFO       PIC X(8).
             02 EXIT-X-WORK-AREA PIC X(4) OCCURS 8.
             02 EXIT-MESSAGE-PARMS.
                03 EXIT-MESSAGE-NUM PIC 9(4)   COMP.
                03 EXIT-DEFAULT-SEV PIC 9(4)   COMP.
                03 EXIT-USER-SEV    PIC S9(4)  COMP.

          01 EXIT-STRINGS.
             02 EXIT-STRING OCCURS 6.
                03 EXIT-STR-LEN PIC 9(4)   COMP.
                03 EXIT-STR-TXT PIC X(64).

      *****************************************************************
      *                                                               *
      *  Begin PROCEDURE DIVISION                                     *
      *                                                               *
      *  Invoke the section to handle the exit.                       *
      *                                                               *
      *****************************************************************

       Procedure Division Using UXPARM.

           Set Address of EXIT-STRINGS to EXIT-PARMS

           COMPUTE EXIT-RETURNCODE = 0

           Evaluate TRUE

      *****************************************************************
      * Handle a bad invocation of this exit by the compiler.         *
      * This could happen if this routine was used for one of the     *
      * other EXITs, such as INEXIT, PRTEXIT or LIBEXIT.              *
      *****************************************************************
             When EXIT-TYPE Not = 6
               Move EXIT-TYPE   to  EXIT-TYPEN
               Display '**** Invalid exit routine identifier'
               Display '**** EXIT TYPE =  '  EXIT-TYPE
               Compute EXIT-RETURNCODE = 16

      *****************************************************************
      * Handle the OPEN call to this exit by the compiler             *
      *        Display the exit string (labeled 'str5' in the syntax  *
      *        diagram in the COBOL for AIX Programming Guide) from   *
      *        the EXIT(MSGEXIT('str5',mod5)) option specification.   *
      *        (Note that str5 is placed in element 6 of the array of *
      *        user exit parameter strings.)                          *
      *****************************************************************
             When EXIT-OPERATION = 0
      *        Display 'Opening MSGEXIT'
      *        If EXIT-STR-LEN(6) Not Zero Then
      *          Display ' str5 len = ' EXIT-STR-LEN(6)
      *          Display ' str5 = ' EXIT-STR-TXT(6)(1:EXIT-STR-LEN)
      *        End-If
               Continue

      *****************************************************************
      * Handle the CLOSE call to this exit by the compiler            *
      *        NOTE: Unlike the z/OS MSGEXIT, you must not use
      *             STOP RUN here.  On AIX, use GOBACK.
      *****************************************************************
             When EXIT-OPERATION = 1
      *        Display 'Closing MSGEXIT'
               Goback

      *****************************************************************
      * Handle the customize message severity call to this exit       *
      *        Display information about every customized severity.   *
      *****************************************************************
             When EXIT-OPERATION = 5
      *        Display 'MSGEXIT called with MSGSEV'
               If EXIT-MESSAGE-NUM < 8000 Then
                 Perform Error-Messages-Severity
               Else
                 Perform FIPS-Messages-Severity
               End-If

      *        If EXIT-RETURNCODE = 4 Then
      *          Display '>>>> Customizing message ' EXIT=MESSAGE-NUM
      *                  ' with new severity ' EXIT-USER-SEV '  <<<<'
      *          If EXIT-MESSAGE-NUM > 8000 Then
      *            Display 'FIPS sev =' EXIT-DEFAULT-SEV-FIPS '<<<<'
      *          End-If
      *        End-If

      *****************************************************************
      * Handle a bad invocation of this exit by the compiler          *
      * The compiler should not invoke this exit with EXIT-TYPE = 6   *
      * and an opcode other than 0, 1, or 5.  This should not happen  *
      * and IBM service should be contacted if it does.               *
      *****************************************************************
             When Other
               Display '**** Invalid MSGEXIT routine operation '
               Display '**** EXIT OPCODE =  '  EXIT-OPERATION
               Compute EXIT-RETURNCODE = 16

           End-Evaluate

           Goback.

      *******************************************************
      *    ERROR MESSAGE   PROCESSOR                        *
      *******************************************************
       Error-Messages-Severity.

      *    Assume message severity will be customized...
           COMPUTE EXIT-RETURNCODE = 4

           Evaluate EXIT-MESSAGE-NUM

      *******************************************************
      *      Change severity of message 1154(W) to 12 ("S")
      *      This is the case of redefining a large item
      *      with a smaller item, IBM Req # MR0904063236
      *******************************************************
             When(1154)
               COMPUTE EXIT-USER-SEV = 12

      *******************************************************
      *      Message severity Not customized
      *******************************************************
             When Other
               COMPUTE EXIT-RETURNCODE = 0

           End-Evaluate
           .
      *******************************************************
      *    FIPS MESSAGE   PROCESSOR                         *
      *******************************************************
       Fips-Messages-Severity.

      *    Assume message severity will be customized...
           COMPUTE EXIT-RETURNCODE = 4

      *    Convert numeric 'category' to character
           EVALUATE EXIT-DEFAULT-SEV
             When 81
               MOVE 'D' To EXIT-DEFAULT-SEV-FIPS
             When 82
               MOVE 'E' To EXIT-DEFAULT-SEV-FIPS
             When 83
               MOVE 'H' To EXIT-DEFAULT-SEV-FIPS
             When 84
               MOVE 'I' To EXIT-DEFAULT-SEV-FIPS
             When 85
               MOVE 'N' To EXIT-DEFAULT-SEV-FIPS
             When 86
               MOVE 'O' To EXIT-DEFAULT-SEV-FIPS
             When 87
               MOVE 'Q' To EXIT-DEFAULT-SEV-FIPS
             When 88
               MOVE 'S' To EXIT-DEFAULT-SEV-FIPS
             When Other
               Continue
           End-Evaluate

      *******************************************************
      *  Examples of using FIPS category to force coding
      *  restrictions.  These are not recommendations!
      *******************************************************
      *      Change severity of all OBSOLETE item FIPS
      *       messages to 'S'
      *******************************************************
      *    If EXIT-DEFAULT-SEV-FIPS = 'O' Then
      *      DISPLAY ">>>> Default customizing FIPS category "
      *        EXIT-DEFAULT-SEV-FIPS " msg " EXIT-MESSAGE-NUM "<<<<"
      *      COMPUTE EXIT-USER-SEV = 12
      *    End-If

           Evaluate EXIT-MESSAGE-NUM
      *******************************************************
      *      Change severity of message 8062(O) to 8 ("E")
      *        8062 = GO TO without proc name
      *******************************************************
             When(8062)
      *        DISPLAY ">>>> Customizing message 8062 with 8 <<<<"
      *        DISPLAY 'FIPS sev =' EXIT-DEFAULT-SEV-FIPS '='
               COMPUTE EXIT-USER-SEV = 8

      *******************************************************
      *      Change severity of message 8193(E) to 0("I")
      *        8193 = GOBACK
      *******************************************************
             When(8193)
      *        DISPLAY ">>>> Customizing message 8193 with 0 <<<<"
      *        DISPLAY 'FIPS sev =' EXIT-DEFAULT-SEV-FIPS '='
               COMPUTE EXIT-USER-SEV = 0

      *******************************************************
      *      Change severity of message 8235(E) to 8 (Error)
      *      to disalllow Complex Occurs Depending On
      *        8235 = Complex Occurs Depending On
      *******************************************************
             When(8235)
      *        DISPLAY ">>>> Customizing message 8235 with 8 <<<<"
      *        DISPLAY 'FIPS sev =' EXIT-DEFAULT-SEV-FIPS '='
               COMPUTE EXIT-USER-SEV = 08

      *******************************************************
      *      Change severity of message 8270(O) to -1 (Suppress)
      *        8270 = SERVICE LABEL
      *******************************************************
             When(8270)
      *        DISPLAY ">>>> Customizing message 8270 with -1 <<<<"
      *        DISPLAY 'FIPS sev =' EXIT-DEFAULT-SEV-FIPS '='
               COMPUTE EXIT-USER-SEV = -1

      *******************************************************
      *      Message severity Not customized
      *******************************************************
             When Other
      *        For the default set 'O' to 'S' case...
      *        If EXIT-USER-SEV = 12 Then
      *          COMPUTE EXIT-RETURNCODE = 4
      *        Else
                 COMPUTE EXIT-RETURNCODE = 0
      *        End-If

           End-Evaluate
           .
       END PROGRAM IGYMSGXT.
