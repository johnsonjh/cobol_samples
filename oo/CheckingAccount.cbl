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
       Class-id. CheckingAccount inherits Account.
       Environment Division.
       Configuration section.
       Repository.
           Class CheckingAccount is "CheckingAccount"
           Class Check           is "Check"
           Class Account         is "Account".
       Identification division.
       Factory.
        Data division.
        Working-storage section.
        01 NumberOfCheckingAccounts pic 9(6) value zero.

        Procedure Division.
         Identification Division.
         Method-id. "createCheckingAccount".
         Data division.
         Linkage section.
         01 inAccountNumber  pic S9(6) binary.
         01 outCheckingAccount object reference CheckingAccount.
           Copy JNI.
         Procedure Division using by value inAccountNumber
             returning outCheckingAccount.
           Set address of JNIEnv to JNIEnvPtr
           Set address of JNINativeInterface to JNIEnv

           Invoke CheckingAccount New returning outCheckingAccount
           Invoke outCheckingAccount "init"
             using by value inAccountNumber
           Add 1 to NumberOfCheckingAccounts.
         End method "createCheckingAccount".

         Identification Division.
         Method-id. "createCheckingAccount".
         Data division.
         Linkage section.
         01 inAccountNumber  pic S9(6) binary.
         01 inInitialBalance pic S9(9) binary.
         01 outCheckingAccount object reference CheckingAccount.
           Copy JNI.
         Procedure Division using by value inAccountNumber
                                           inInitialBalance
             returning outCheckingAccount.
           Set address of JNIEnv to JNIEnvPtr
           Set address of JNINativeInterface to JNIEnv

           Invoke CheckingAccount New returning outCheckingAccount
           Invoke outCheckingAccount "init"
             using by value inAccountNumber
           Invoke outCheckingAccount "credit"
             using by value inInitialBalance
           Add 1 to NumberOfCheckingAccounts.
         End method "createCheckingAccount".
       End Factory.

       Identification division.
       Object.
        Data division.
        Working-storage section.
        01 CheckFee pic S9(9) value 1.
        Procedure Division.

         Identification Division.
         Method-id. "processCheck".
         Data division.
         Local-storage section.
         01 amount pic S9(9) binary.
         01 payee usage object reference Account.
         Linkage section.
         01 aCheck usage object reference Check.
         Procedure Division using by value aCheck.
            Invoke aCheck "getAmount" returning amount
            Invoke aCheck "getPayee" returning payee
            Invoke payee  "credit" using by value amount
            Add checkFee to amount
            Invoke self   "debit"  using by value amount.
         End method "processCheck".

         Identification Division.
         Method-id. "print".
         Data division.
         Local-storage section.
         01 printableFee pic $$,$$$,$$9.
         Procedure Division.
            Invoke super "print"
            Move CheckFee to printableFee
            Display " Check fee: " printableFee.
         End method "print".
       End Object.
       End class CheckingAccount.
