/*
       ######################################################################
       #                                                                    #
       #   Licensed Materials - Property of IBM.                            #
       #   5724-Z87                                                         #
       #   Copyright IBM Corp. 2004,2010.                                   #
       #   All Rights Reserved.                                             #
       #   US Government Users Restricted Rights -                          #
       #   Use, duplication or disclosure restricted by                     #
       #   GSA ADP Schedule Contract with IBM Corp.                         #
       #                                                                    #
       #   This file contains sample code.  You may copy, modify, and       #
       #   distribute these samples, or their modifications, in any         #
       #   form, internally or as part of Your application or related       #
       #   documentation. These samples have not been tested under all      #
       #   conditions and are provided to You by IBM without obligation     #
       #   of support of any kind. IBM PROVIDES THESE SAMPLES "AS IS"       #
       #   SUBJECT TO ANY STATUTORY WARRANTIES THAT CANNOT BE EXCLUDED.     #
       #   IBM MAKES NO WARRANTIES OR CONDITIONS, EITHER EXPRESS OR         #
       #   IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES    #
       #   OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR       #
       #   PURPOSE, AND NON-INFRINGEMENT REGARDING THESE SAMPLES OR         #
       #   TECHNICAL SUPPORT, IF ANY. You will indemnify IBM or third       #
       #   parties that provide IBM products ("Third Parties") from and     #
       #   against any third party claim arising out of the use,            #
       #   modification or distribution of these samples with Your          #
       #   application. You may not use the same path name as the           #
       #   original files/modules. You must not alter or delete any         #
       #   copyright information in the Samples.                            #
       #                                                                    #
       ######################################################################
*/

public class Check {
  private CheckingAccount payer;
  private Account payee;
  private int amount;
  public Check(CheckingAccount inPayer, Account inPayee, int inAmount) {
    payer=inPayer;
    payee=inPayee;
    amount=inAmount;
  }
  public int getAmount() {
    return amount;
  }
  public Account getPayee() {
    return payee;
  }
}
