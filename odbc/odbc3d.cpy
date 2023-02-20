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
      * ODBC3D.CPY                 (ODBC Ver 3.0)                      *
      *----------------------------------------------------------------*
      * Data definitions to be used with sample ODBC function calls    *
      *  and included in WORKING-STORAGE or LOCAL-STORAGE SECTION      *
      ******************************************************************
      * ODBC Handles
       01  Henv                       POINTER            VALUE NULL.
       01  Hdbc                       POINTER            VALUE NULL.
       01  Hstmt                      POINTER            VALUE NULL.

      * Arguments used for GetDiagRec calls
       01  DiagHandleType             COMP-5  PIC 9(4).
       01  DiagHandle                 POINTER.
       01  DiagRecNumber              COMP-5  PIC 9(4).
       01  DiagRecNumber-Index        COMP-5  PIC 9(4).
       01  DiagSQLState.
           02 DiagSQLState-Chars              PIC X(5).
           02 DiagSQLState-Null               PIC X.
       01  DiagNativeError            COMP-5  PIC S9(9).
       01  DiagMessageText                    PIC X(511) VALUE SPACES.
       01  DiagMessageBufferLength    COMP-5  PIC S9(4)  VALUE 511.
       01  DiagMessageTextLength      COMP-5  PIC S9(4).

      * Misc declarations used in sample function calls
       01  SQL-RC                     COMP-5  PIC S9(4)  VALUE 0.
       01  Saved-SQL-RC               COMP-5  PIC S9(4)  VALUE 0.
       01  SQL-stmt                           PIC X(30).

      *************************
      * End of ODBC3D.CPY     *
      *************************
