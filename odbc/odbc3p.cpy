      *######################################################################
      *#                                                                    #
      *#   Licensed Materials - Property of IBM.                            #
      *#   5724-Z87                                                         #
      *#   Copyright IBM Corp. 2004,2010.                                   #
      *#   All Rights Reserved.                                             #
      *#   US Government Users Restricted Rights -                          #
      *#   Use, duplication or disclosure restricted by                     #
      *#   GSA ADP Schedule Contract with IBM Corp.                         #
      *#                                                                    #
      *#   This file contains sample code.  You may copy, modify, and       #
      *#   distribute these samples, or their modifications, in any         #
      *#   form, internally or as part of Your application or related       #
      *#   documentation. These samples have not been tested under all      #
      *#   conditions and are provided to You by IBM without obligation     #
      *#   of support of any kind. IBM PROVIDES THESE SAMPLES "AS IS"       #
      *#   SUBJECT TO ANY STATUTORY WARRANTIES THAT CANNOT BE EXCLUDED.     #
      *#   IBM MAKES NO WARRANTIES OR CONDITIONS, EITHER EXPRESS OR         #
      *#   IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES    #
      *#   OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR       #
      *#   PURPOSE, AND NON-INFRINGEMENT REGARDING THESE SAMPLES OR         #
      *#   TECHNICAL SUPPORT, IF ANY. You will indemnify IBM or third       #
      *#   parties that provide IBM products ("Third Parties") from and     #
      *#   against any third party claim arising out of the use,            #
      *#   modification or distribution of these samples with Your          #
      *#   application. You may not use the same path name as the           #
      *#   original files/modules. You must not alter or delete any         #
      *#   copyright information in the Samples.                            #
      *#                                                                    #
      *######################################################################

      ******************************************************************
      * ODBC3P.CPY                                                     *
      *----------------------------------------------------------------*
      *  Sample ODBC initialization, clean-up and error handling       *
      *    procedures    (ODBC Ver 3.0)                                *
      ******************************************************************
      *** Initialization functions SECTION *****************************
       ODBC-Initialization SECTION.
      *
        Allocate-Environment-Handle.
           CALL "SQLAllocHandle" USING
                                   BY VALUE     SQL-HANDLE-ENV
                                   BY VALUE     SQL-NULL-HANDLE
                                   BY REFERENCE Henv
                                 RETURNING      SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
             MOVE "SQLAllocHandle for Env" TO SQL-stmt
             MOVE SQL-HANDLE-ENV to DiagHandleType
             SET DiagHandle to Henv
             PERFORM SQLDiag-Function
           END-IF.
      *
        Set-Env-Attr-to-Ver30-Behavior.
           CALL "SQLSetEnvAttr" USING
                                  BY VALUE      Henv
                                  BY VALUE      SQL-ATTR-ODBC-VERSION
                                  BY VALUE      SQL-OV-ODBC3
      *                                      or SQL-OV-ODBC2         *
      *                                         for Ver 2.x behavior *
                                  BY VALUE      SQL-IS-UINTEGER
                               RETURNING        SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
             MOVE "SQLSetEnvAttr" TO SQL-stmt
             MOVE SQL-HANDLE-ENV to DiagHandleType
             SET DiagHandle to Henv
             PERFORM SQLDiag-Function
           END-IF.
      *
        Allocate-Connection-Handle.
           CALL "SQLAllocHandle" USING
                                   By VALUE     SQL-HANDLE-DBC
                                   BY VALUE     Henv
                                   BY REFERENCE Hdbc
                                 RETURNING      SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLAllocHandle for Connection" to SQL-stmt
               MOVE SQL-HANDLE-ENV to DiagHandleType
               SET DiagHandle to Henv
               PERFORM SQLDiag-Function
           END-IF.

      *** SQLAllocHandle for statement function SECTION ***************
       Allocate-Statement-Handle SECTION.
        Allocate-Stmt-Handle.
           CALL "SQLAllocHandle" USING
                                   By VALUE     SQL-HANDLE-STMT
                                   BY VALUE     Hdbc
                                   BY REFERENCE Hstmt
                                 RETURNING      SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLAllocHandle for Stmt" TO SQL-stmt
               MOVE SQL-HANDLE-DBC to DiagHandleType
               SET DiagHandle to Hdbc
               PERFORM SQLDiag-Function
           END-IF.

      *** Cleanup Functions SECTION ***********************************
       ODBC-Clean-Up SECTION.
      *
        Free-Statement-Handle.
           CALL "SQLFreeHandle" USING
                                  BY VALUE SQL-HANDLE-STMT
                                  BY VALUE Hstmt
                                RETURNING  SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeHandle for Stmt" TO SQL-stmt
               MOVE SQL-HANDLE-STMT to DiagHandleType
               SET DiagHandle to Hstmt
               PERFORM SQLDiag-Function
           END-IF.
      *
        SQLDisconnect-Function.
           CALL "SQLDisconnect" USING
                                  BY VALUE Hdbc
                                RETURNING  SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLDisconnect" TO SQL-stmt
               MOVE SQL-HANDLE-DBC to DiagHandleType
               SET DiagHandle to Hdbc
               PERFORM SQLDiag-Function
           END-IF.
      *
        Free-Connection-Handle.
           CALL "SQLFreeHandle" USING
                                  BY VALUE SQL-HANDLE-DBC
                                  BY VALUE Hdbc
                                RETURNING  SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeHandle for DBC" TO SQL-stmt
               MOVE SQL-HANDLE-DBC to DiagHandleType
               SET DiagHandle to Hdbc
               PERFORM SQLDiag-Function
           END-IF.
      *
        Free-Environment-Handle.
           CALL "SQLFreeHandle" USING
                                  BY VALUE SQL-HANDLE-ENV
                                  BY VALUE Henv
                                RETURNING  SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeHandle for Env" TO SQL-stmt
               MOVE SQL-HANDLE-ENV to DiagHandleType
               SET DiagHandle to Henv
               PERFORM SQLDiag-Function
           END-IF.

      *** SQLDiag function SECTION ************************************
       SQLDiag-Function SECTION.
        SQLDiag.
           MOVE SQL-RC TO SAVED-SQL-RC
           DISPLAY "Return Value = " SQL-RC

             IF SQL-RC = SQL-SUCCESS-WITH-INFO
               THEN
                  DISPLAY SQL-stmt " successful with information"
               ELSE
                  DISPLAY SQL-stmt " failed"
             END-IF

      *    - get number of diagnostic records - *
           CALL "SQLGetDiagField"
                   USING
                     BY VALUE     DiagHandleType
                                  DiagHandle
                                  0
                                  SQL-DIAG-NUMBER
                     BY REFERENCE DiagRecNumber
                     BY VALUE     SQL-IS-SMALLINT
                     BY REFERENCE OMITTED
                   RETURNING      SQL-RC

           IF SQL-RC = SQL-SUCCESS or SQL-SUCCESS-WITH-INFO
             THEN

      *        - get each diagnostic record - *
               PERFORM WITH TEST AFTER
                 VARYING DiagRecNumber-Index FROM 1 BY 1
                   UNTIL DiagRecNumber-Index > DiagRecNumber
                    or   SQL-RC NOT =
                           (SQL-SUCCESS or SQL-SUCCESS-WITH-INFO)

      *          - get a diagnostic record - *
                 CALL "SQLGetDiagRec"
                         USING
                           BY VALUE     DiagHandleType
                                        DiagHandle
                                        DiagRecNumber-Index
                           BY REFERENCE DiagSQLState
                                        DiagNativeError
                                        DiagMessageText
                           BY VALUE     DiagMessageBufferLength
                           BY REFERENCE DiagMessageTextLength
                         RETURNING          SQL-RC

                 IF SQL-RC = SQL-SUCCESS OR SQL-SUCCESS-WITH-INFO
                   THEN
                     DISPLAY "Information from diagnostic record number"
                             " " DiagRecNumber-Index " for "
                             SQL-stmt ":"
                     DISPLAY "  SQL-State = " DiagSQLState-Chars
                     DISPLAY "  Native error code = " DiagNativeError
                     DISPLAY "  Diagnostic message = "
                              DiagMessageText (1:DiagMessageTextLength)
                   ELSE
                     DISPLAY "SQLGetDiagRec request for " SQL-stmt
                             " failed with return code of: " SQL-RC
                             " from SQLError"
                     PERFORM Termination
                 END-IF
               END-PERFORM

             ELSE
      *        - indicate SQLGetDiagField failed - *
               DISPLAY "SQLGetDiagField failed with return code of: "
                       SQL-RC
           END-IF

           MOVE Saved-SQL-RC to SQL-RC
           IF Saved-SQL-RC NOT = SQL-SUCCESS-WITH-INFO
             PERFORM Termination
           END-IF.

      *** Termination Section******************************************
       Termination Section.
        Termination-Function.
           DISPLAY "Application being terminated with rollback"
           CALL "SQLTransact" USING BY VALUE henv
                                             hdbc
                                             SQL-ROLLBACK
                              RETURNING      SQL-RC

           IF SQL-RC = SQL-SUCCESS
             THEN
               DISPLAY "Rollback successful"
             ELSE
               DISPLAY "Rollback failed with return code of: "
                       SQL-RC
           END-IF
           STOP RUN.

      *************************
      * End of ODBC3P.CPY     *
      *************************
