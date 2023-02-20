      cbl  pgmname(mixed)
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
      * ODBC3EG.CBL                                                    *
      *----------------------------------------------------------------*
      * Sample program using ODBC3, ODBC3D and ODBC3P COPY books       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. "ODBC3EG".
       DATA DIVISION.

       WORKING-STORAGE SECTION.
      *  copy ODBC API constant definitions
           COPY "odbc3.cpy" SUPPRESS.

      *  copy additional definitions used by ODBC30PROC procedure
           COPY "odbc3d.cpy".

      *  arguments used for SQLConnect
       01  ServerName                    PIC X(10) VALUE Z"Oracle7".
       01  ServerNameLength       COMP-5 PIC S9(4) VALUE 10.
       01  UserId                        PIC X(10) VALUE Z"TEST123".
       01  UserIdLength           COMP-5 PIC S9(4) VALUE 10.
       01  Authentication                PIC X(10) VALUE Z"TEST123".
       01  AuthenticationLength   COMP-5 PIC S9(4) VALUE 10.

       PROCEDURE DIVISION.
       Do-ODBC SECTION.
        Start-ODBC.
           DISPLAY "Sample ODBC 3.0 program starts"

      *  allocate henv & hdbc
           PERFORM ODBC-Initialization

      *  connect to data source
           CALL "SQLConnect" USING BY VALUE     Hdbc
                                   BY REFERENCE ServerName
                                   BY VALUE     ServerNameLength
                                   BY REFERENCE UserId
                                   BY VALUE     UserIdLength
                                   BY REFERENCE Authentication
                                   BY VALUE     AuthenticationLength
                             RETURNING SQL-RC

           IF SQL-RC NOT = SQL-SUCCESS
             MOVE "SQLConnect" to SQL-stmt
             MOVE SQL-HANDLE-DBC to DiagHandleType
             SET DiagHandle to Hdbc
             PERFORM SQLDiag-Function
           END-IF

      *  allocate hstmt
           PERFORM Allocate-Statement-Handle

      *****************************************
      *  add application specific logic here  *
      *****************************************

      *  clean-up environment
           PERFORM ODBC-Clean-Up.

      *  End of sample program execution
           DISPLAY "Sample COBOL ODBC program ended"
           GOBACK.

      *  copy predefined COBOL ODBC calls which are performed
           COPY "odbc3p.cpy".
      *******************************************************
      * End of ODBC3EG.CBL:  Sample program for ODBC 3.0 *
      *******************************************************
