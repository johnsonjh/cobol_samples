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
      * ODBCPROC.CPY                                                   *
      *----------------------------------------------------------------*
      *  Sample ODBC initialization, clean-up and error handling       *
      *    procedures                                                  *
      ******************************************************************
      *** Initialization functions SECTION *****************************
       ODBC-Initialization SECTION.
      *
        SQLAllocEnv-Function.
           CALL "SQLAllocEnv" USING BY REFERENCE Henv
                              RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
             MOVE "SQLAllocEnv" TO SQL-stmt
             PERFORM SQLError-Function
           END-IF.
      *
        SQLAllocConnect-Function.
           CALL "SQLAllocConnect" USING BY VALUE     Henv
                                        BY REFERENCE Hdbc
                                  RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLAllocConnect" to SQL-stmt
               PERFORM SQLError-Function
           END-IF.

      *** SQLAllocStmt function SECTION *******************************
       SQLAllocStmt-Function SECTION.
        SQLAllocStmt.
           CALL "SQLAllocStmt" USING BY VALUE     Hdbc
                                     BY REFERENCE Hstmt
                               RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLAllocStmt" TO SQL-stmt
               PERFORM SQLError-Function
           END-IF.

      *** Cleanup Functions SECTION ***********************************
       ODBC-Clean-Up SECTION.
      *
        SQLFreeStmt-Function.
           CALL "SQLFreeStmt" USING BY VALUE Hstmt
                                             SQL-DROP
                              RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeStmt" TO SQL-stmt
               PERFORM SQLError-Function
           END-IF.
      *
        SQLDisconnect-Function.
           CALL "SQLDisconnect" USING BY VALUE Hdbc
                                RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLDisconnect" TO SQL-stmt
               PERFORM SQLError-Function
           END-IF.
      *
        SQLFreeConnect-Function.
           CALL "SQLFreeConnect" USING BY VALUE Hdbc
                                 RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeConnect" TO SQL-stmt
               PERFORM SQLError-Function
           END-IF.
      *
        SQLFreeEnv-Function.
           CALL "SQLFreeEnv" USING BY VALUE Henv
                             RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
               MOVE "SQLFreeEnv" TO SQL-stmt
               PERFORM SQLError-Function
           END-IF.

      *** SQLError function SECTION ************************************
       SQLError-Function SECTION.
        SQLError.
           MOVE SQL-RC TO SAVED-SQL-RC
           DISPLAY "Return Value = " SQL-RC
           PERFORM WITH TEST AFTER UNTIL SQL-RC =  SQL-SUCCESS
                                                OR SQL-NO-DATA-FOUND
                                                OR SQL-INVALID-HANDLE

             IF SQL-RC = SQL-SUCCESS-WITH-INFO
               THEN
                  DISPLAY SQL-stmt " successful with information"
               ELSE
                  DISPLAY SQL-stmt " failed"
             END-IF

             CALL "SQLError" USING BY VALUE     Henv
                                                Hdbc
                                                Hstmt
                                   BY REFERENCE szSqlState
                                                fNativeError
                                                szErrorMsg
                                   BY VALUE     cbErrorMsgMax
                                   BY REFERENCE cbErrorMsg
                             RETURNING SQL-RC
             IF SQL-RC = SQL-SUCCESS OR SQL-SUCCESS-WITH-INFO
               THEN
                 DISPLAY "SQL-State = " szSQLState-Chars
                 INSPECT szErrorMsg TALLYING char-count
                                    FOR CHARACTERS BEFORE X"00"
                 DISPLAY "Message = " szErrorMsg (1:char-count)
                 MOVE 0 TO char-count
               ELSE
                 DISPLAY "Return value = " SQL-RC
             END-IF
                 MOVE "SQLError" TO SQL-stmt
           END-PERFORM

           IF Saved-SQL-RC NOT = SQL-SUCCESS-WITH-INFO
             DISPLAY "Application being terminated"
      *       you might do <CALL "SQLTransact" USING BY VALUE ...
      *       SQL-Rollback> or some other processing here.
             STOP RUN
           END-IF.
      ***********************
      * End of ODBCPROC.CPY *
      ***********************
