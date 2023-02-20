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
      * ODBCSAMP.CBL                                                   *
      *----------------------------------------------------------------*
      * Sample program using ODBCCOB, ODBCDATA and ODBCPROC            *
      * COPY books                                                     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. "ODBC-Sample".
       DATA DIVISION.

       WORKING-STORAGE SECTION.
      *  copy ODBC API constant definitions
           COPY "odbc2.cpy" SUPPRESS.

      *  copy additional definitions used by ODBCPROC procedure
           COPY "odbcdata.cpy".

      *  arguments used for SQLConnect
       01  szDSN                     PIC X(10) VALUE Z"myDSN".
       01  szUID                     PIC X(10) VALUE Z"userid".
       01  szAuthStr                 PIC X(10) VALUE Z"password".

       PROCEDURE DIVISION.
       Do-ODBC SECTION.
        Start-ODBC.
           DISPLAY "Sample ODBC program starts"

      *  allocate henv & hdbc
           PERFORM ODBC-Initialization

      *  connect to data source
           CALL "SQLConnect" USING BY VALUE     Hdbc
                                   BY REFERENCE szDSN
                                   BY VALUE     SQL-NTS
                                   BY REFERENCE szUID
                                   BY VALUE     SQL-NTS
                                   BY REFERENCE szAuthStr
                                   BY VALUE     SQL-NTS
                             RETURNING SQL-RC
           IF SQL-RC NOT = SQL-SUCCESS
             DISPLAY "SQLConnect failed"
             PERFORM SQLError-Function
           END-IF

      *  allocate hstmt
           PERFORM SQLAllocStmt-Function.

      *****************************************
      *  add application specific logic here  *
      *****************************************

      *  clean-up environment
           PERFORM ODBC-Clean-Up.

      *  End of sample program execution
           GOBACK.

      *  copy predefined COBOL ODBC calls which are performed
           COPY "odbcproc.cpy".
      *********************************************
      * End of ODBCSAMP.CBL:  ODBC-Sample program *
      *********************************************
