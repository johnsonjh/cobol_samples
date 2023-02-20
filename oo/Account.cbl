       cbl thread,pgmname(longmixed),lib
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

       Identification Division.
       Class-id. Account inherits Base.
       Environment Division.
       Configuration section.
       Repository.
           Class Base is "java.lang.Object"
           Class Account is "Account".
       Identification division.
       Factory.
        Data division.
        Working-storage section.
        01 NumberOfAccounts pic 9(6) value zero.

        Procedure Division.
         Identification Division.
         Method-id. "createAccount".
         Data division.
         Linkage section.
         01 inAccountNumber  pic S9(6) binary.
         01 outAccount object reference Account.
           Copy JNI.
         Procedure Division using by value inAccountNumber
             returning outAccount.
           Set address of JNIEnv to JNIEnvPtr
           Set address of JNINativeInterface to JNIEnv

           Invoke Account New returning outAccount
           Invoke outAccount "init" using by value inAccountNumber
           Add 1 to NumberOfAccounts.
         End method "createAccount".
       End Factory.

       Identification division.
       Object.
        Data division.
        Working-storage section.
        01 AccountNumber pic 9(6).
        01 AccountBalance pic S9(9) value zero.
        Procedure Division.

         Identification Division.
         Method-id. "init".
         Data division.
         Linkage section.
         01 inAccountNumber pic S9(9) binary.
         Procedure Division using by value inAccountNumber.
            Move inAccountNumber to AccountNumber.
         End method "init".

         Identification Division.
         Method-id. "getBalance".
         Data division.
         Linkage section.
         01 outBalance pic S9(9) binary.
         Procedure Division returning outBalance.
           Move AccountBalance to outBalance.
         End method "getBalance".

         Identification Division.
         Method-id. "credit".
         Data division.
         Linkage section.
         01 inCredit   pic S9(9) binary.
         Procedure Division using by value inCredit.
           Add inCredit to AccountBalance.
         End method "credit".

         Identification Division.
         Method-id. "debit".
         Data division.
         Linkage section.
         01 inDebit    pic S9(9) binary.
         Procedure Division using by value inDebit.
           Subtract inDebit from AccountBalance.
         End method "debit".

         Identification Division.
         Method-id. "print".
         Data division.
         Local-storage section.
         01 PrintableAccountNumber  pic ZZZZZZ999999.
         01 PrintableAccountBalance pic $$$$,$$$,$$9CR.
         Procedure Division.
           Move AccountNumber  to PrintableAccountNumber
           Move AccountBalance to PrintableAccountBalance
           Display " Account: " PrintableAccountNumber
           Display " Balance: " PrintableAccountBalance.
         End method "print".

       End Object.
       End class Account.

