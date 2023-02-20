       cbl thread,pgmname(longmixed)
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

       Identification division.
       Program-id. "TestAccounts" recursive.
       Environment division.
       Configuration section.
       Repository.
           Class Account         is "Account"
           Class CheckingAccount is "CheckingAccount"
           Class Check           is "Check".
       Data Division.
       Local-storage section.
       01  anAccount        usage object reference Account.
       01  aCheckingAccount usage object reference CheckingAccount.
       01  aCheck           usage object reference Check.
       01  payee            usage object reference Account.
       Procedure division.
       Test-Account-section.
           Display "Test Account class"
           Invoke Account "createAccount"
             using by value 123456
             returning anAccount
           Invoke anAccount "credit" using by value 500
           Invoke anAccount "print"
           Display space

           Display "Test CheckingAccount class"
           Invoke CheckingAccount "createCheckingAccount"
             using by value 777777 300
             returning aCheckingAccount
           Set payee to anAccount
           Invoke Check New
             using by value aCheckingAccount, payee, 125
             returning aCheck
           Invoke aCheckingAccount "processCheck"
             using by value aCheck
           Invoke aCheckingAccount "print"
           Invoke anAccount "print"

           Goback.
       End program "TestAccounts".

