global without sharing class SalesForecasts_ctrl {
    public Map < id, set < id >> UserId_subordinateList_Map {get;        set;}
    public Map < id, set < id > > UserId_SalesRep_subordinate_Map {get;set;}
    public Map < id, List < AccountWrapper >> UserId_AccountList_Map {get;set;}
    public Map < id, AccountWrapper > UserId_Totals {get;set;}
    public Map < id, AccountWrapper > UserId_ownTotals {get;set;}
    public Map < id, User > UserId_User_Map {get;set;}
    public List < SelectOption > userHierarchy {get;set;}
    public Id selectedUserId {get;set;}
    public set < id > currentUserSubordinatesIds {get;set;}
    public Map < id, boolean > userID_hasSaleRep {get;set;}
    public Date defaultDate {get;set;}
    public Date stDate {get;set;}
    public Date endDate {get;set;}
    public String defaultDateTest {get;set;}
    public String currentField {get;set;}
    public String previousField {get;set;}
    public String sortDirection {get;set;}
    public integer currentYear{get;set;}
    public boolean isShowDateField{get;set;}
    public integer year{get;set;}
    public SalesForecasts_ctrl() {

        User temp_u = [select id, Forecast_Sort__c,Forecast_Year__c, Forecast_Sort_Field__c from User where id =: UserInfo.getUserId() limit 1];
        if (temp_u.Forecast_Sort__c == null)
            sortDirection = 'asc';
        else {
            if (temp_u.Forecast_Sort__c == 'asc' || temp_u.Forecast_Sort__c == 'desc')
                sortDirection = temp_u.Forecast_Sort__c;
            else
                sortDirection = 'asc';
        }
        if (temp_u.Forecast_Sort_Field__c == null) {
            currentField = 'Forecast_Status';
            previousField = 'Forecast_Status'; //accName
        } else {
            if (new set < String > {
                    'accName',
                    'forecast',
                    'cwSum_2year',
                    'cwSum_1year',
                    'pAmountSum',
                    'cwSum',
                    'openSum'
                }.contains(temp_u.Forecast_Sort_Field__c)) {
                currentField = temp_u.Forecast_Sort_Field__c;
                previousField = temp_u.Forecast_Sort_Field__c;
            } else {
                currentField = 'accName';
                previousField = 'accName';
            }
        }
        currentYear=System.Today().Year();
        try {
            Integer tempYear = Integer.valueOf(apexpages.currentpage().getparameters().get('year'));
            defaultDateTest = '01/01/' + tempYear;
            stDate = Date.newInstance(tempYear, 1, 1);
            endDate = Date.newInstance(tempYear + 1, 1, 1);
        } catch (Exception e) {
            if(temp_u.Forecast_Year__c!=null){
                defaultDateTest = '01/01/'+temp_u.Forecast_Year__c;

                stDate = Date.newInstance(Integer.valueOf(temp_u.Forecast_Year__c), 1, 1);
                endDate = Date.newInstance(Integer.valueOf(temp_u.Forecast_Year__c)+1, 1, 1);
            }
            else{
                defaultDateTest = '01/01/' + (System.Today().year() + 1);
                stDate = Date.newInstance(System.Today().year() + 1, 1, 1);
                endDate = Date.newInstance(System.Today().year() + 2, 1, 1);
            }
        }
        isShowDateField=false;
        if(currentYear==stDate.year()||currentYear==stDate.year()-1||currentYear==stDate.year()+1)
            isShowDateField=true;

        year=stDate.year();    

        UserId_subordinateList_Map = new Map < id, set < id >> ();
        UserId_SalesRep_subordinate_Map = new Map < id, set < id >> ();

        UserId_User_Map = new Map < id, User > ();
        currentUserSubordinatesIds = new set < id > ();
        defaultDate = System.today().addyears(1);

        userID_hasSaleRep = new Map < id, boolean > ();


        for (user u: [select id, name, SalesRepId1__c, Manager.name from user where isactive = true order by Manager.name]) {
            UserId_subordinateList_Map.put(u.id, new set < id > ());
            UserId_SalesRep_subordinate_Map.put(u.id, new set < id > ());
            UserId_User_Map.put(u.id, u);
            userID_hasSaleRep.put(u.id, false);
        }
        for (User u: [select id, name, SalesRepId1__c, Manager.id from user where isactive = true and Manager.id != null order by Manager.name]) {
            UserId_subordinateList_Map.get(u.Manager.id).add(u.id);
        }
        // Start of User PickList
        userHierarchy = new List < SelectOption > ();
        selectedUserId = UserInfo.getUserId();

        if (isSalesRep(selectedUserId)) {
            userHierarchy.add(new SelectOption(selectedUserId, UserId_User_Map.get(selectedUserId).Name));
            currentUserSubordinatesIds.add(selectedUserId);
            UserId_SalesRep_subordinate_Map.get(selectedUserId).add(selectedUserId);
            System.debug(UserId_User_Map.get(selectedUserId).Name);
        }


        for (id i: UserId_subordinateList_Map.get(selectedUserId)) {
            if (isSalesRep(i)) {
                userHierarchy.add(new SelectOption(i, '-' + UserId_User_Map.get(i).Name)); //level one    
                currentUserSubordinatesIds.add(i);

                UserId_SalesRep_subordinate_Map.get(selectedUserId).add(i);
                UserId_SalesRep_subordinate_Map.get(i).add(i);
                System.debug(UserId_User_Map.get(i).Name);
            }
            for (id j: UserId_subordinateList_Map.get(i)) {
                if (isSalesRep(j)) {
                    userHierarchy.add(new SelectOption(j, '  --' + UserId_User_Map.get(j).Name)); //level two        
                    currentUserSubordinatesIds.add(j);

                    UserId_SalesRep_subordinate_Map.get(selectedUserId).add(j);
                    UserId_SalesRep_subordinate_Map.get(i).add(j);
                    UserId_SalesRep_subordinate_Map.get(j).add(j);
                    System.debug(UserId_User_Map.get(j).Name);
                }
                for (id k: UserId_subordinateList_Map.get(j)) {
                    if (isSalesRep(k)) {
                        userHierarchy.add(new SelectOption(k, '   ---' + UserId_User_Map.get(k).Name)); //level three            
                        currentUserSubordinatesIds.add(k);

                        UserId_SalesRep_subordinate_Map.get(selectedUserId).add(k);
                        UserId_SalesRep_subordinate_Map.get(i).add(k);
                        UserId_SalesRep_subordinate_Map.get(j).add(k);
                        UserId_SalesRep_subordinate_Map.get(k).add(k);
                        System.debug(UserId_User_Map.get(k).Name);
                    }
                    for (id l: UserId_subordinateList_Map.get(k)) {
                        if (isSalesRep(l)) {
                            userHierarchy.add(new SelectOption(l, '    ----' + UserId_User_Map.get(l).Name)); //level four    
                            currentUserSubordinatesIds.add(l);

                            UserId_SalesRep_subordinate_Map.get(selectedUserId).add(l);
                            UserId_SalesRep_subordinate_Map.get(i).add(l);
                            UserId_SalesRep_subordinate_Map.get(j).add(l);
                            UserId_SalesRep_subordinate_Map.get(k).add(l);
                            UserId_SalesRep_subordinate_Map.get(l).add(l);
                            System.debug(UserId_User_Map.get(l).Name);
                        }
                        for (id m: UserId_subordinateList_Map.get(l)) {
                            if (isSalesRep(m)) {
                                userHierarchy.add(new SelectOption(l, '    -----' + UserId_User_Map.get(m).Name)); //level Five    
                                currentUserSubordinatesIds.add(m);

                                UserId_SalesRep_subordinate_Map.get(selectedUserId).add(m);
                                UserId_SalesRep_subordinate_Map.get(i).add(m);
                                UserId_SalesRep_subordinate_Map.get(j).add(m);
                                UserId_SalesRep_subordinate_Map.get(k).add(m);
                                UserId_SalesRep_subordinate_Map.get(l).add(m);
                                UserId_SalesRep_subordinate_Map.get(m).add(m);
                                System.debug(UserId_User_Map.get(m).Name);
                            }
                        }
                    }
                }
            }
        }
    }
    public boolean isSalesRep(id selectedUserIdK) {
        boolean flag = false;
        if (UserId_User_Map.get(selectedUserIdK).SalesRepId1__c != null) {
            userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
            flag = true;
            return flag;
        }
        for (id i: UserId_subordinateList_Map.get(selectedUserIdK)) {
            if (UserId_User_Map.get(i).SalesRepId1__c != null) {
                userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                flag = true;
                return flag;
            }
            for (id j: UserId_subordinateList_Map.get(i)) {
                if (UserId_User_Map.get(j).SalesRepId1__c != null) {
                    userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                    flag = true;
                    return flag;
                }
                for (id k: UserId_subordinateList_Map.get(j)) {
                    if (UserId_User_Map.get(k).SalesRepId1__c != null) {
                        userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                        flag = true;
                        return flag;
                    }
                    for (id l: UserId_subordinateList_Map.get(k)) {
                        if (UserId_User_Map.get(l).SalesRepId1__c != null) {
                            userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                            flag = true;
                            return flag;
                        }
                        for (id m: UserId_subordinateList_Map.get(l)) {
                            if (UserId_User_Map.get(m).SalesRepId1__c != null) {
                                userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                                flag = true;
                                return flag;
                            }
                            for (id n: UserId_subordinateList_Map.get(m)) {
                                if (UserId_User_Map.get(n).SalesRepId1__c != null) {
                                    userID_hasSaleRep.put(UserId_User_Map.get(selectedUserIdK).id, true);
                                    flag = true;
                                    return flag;
                                }
                            }
                        }
                    }
                }
            }
        }
        return flag;
    }
    public void setFilter() {
        // currentUserSubordinatesIds
        UserId_AccountList_Map = new Map < id, List < AccountWrapper >> ();
        UserId_Totals = new Map < id, AccountWrapper > ();
        UserId_ownTotals = new Map < id, AccountWrapper > ();
        for (user u: [select id, name, SalesRepId1__c, Manager.name from user where isactive = true order by Manager.name]) {
            UserId_Totals.put(u.id, new AccountWrapper());
            UserId_ownTotals.put(u.id, new AccountWrapper());
        }


        for (user u: [select id, SalesRepId1__c, name, Manager.name from user where isactive = true]) {
            UserId_AccountList_Map.put(u.id, new list < AccountWrapper > ());
        }
        set < id > accountids = new set < id > ();
        Map < id, Account_Yearly_Forecast__c > accountId_AYFobj_Map = new Map < id, Account_Yearly_Forecast__c > ();
        for (Account a: [select id from account where Include_in_Forecast__c = true and ownerid in: currentUserSubordinatesIds]) {
            accountids.add(a.id);
        }
        for (Account_Yearly_Forecast__c ayf: [select id,
                Account__r.id,
                Forecast_Status__c,
                                              Budgeted_Sales__c
                from Account_Yearly_Forecast__c
                where Account__r.id != null
                and Account__r.id in: accountids
                and Forecast_Period_Start__c >=: stDate
                and Forecast_Period_Start__c <: endDate
            ]) {

            accountId_AYFobj_Map.put(ayf.Account__r.id, ayf);

        }
        // Map For sum Of Opportunity(Amount) for Account where Stage is Open
        Map < Id, Decimal > oppAmountOpenMap = new Map < Id, Decimal > ();
        for (AggregateResult ar: [SELECT AccountId aId, SUM(Amount) sum
                from opportunity
                where IsClosed = false
                and CloseDate >=: stDate
                and CloseDate <: endDate
                and AccountId In: accountids
                GROUP BY AccountId
            ]) {
            oppAmountOpenMap.put((Id) ar.get('aId'), (Decimal) ar.get('sum')==null?0:(Decimal) ar.get('sum'));
        }
        // Map For sum Of Opportunity(Amount) for Account where Stage is Close/Won
        Map < Id, Decimal > oppAmountCloseWonMap = new Map < Id, Decimal > ();
        for (AggregateResult ar: [SELECT AccountId aId, SUM(Amount) sum
                from opportunity where IsClosed = true and IsWon = True
                and CloseDate >=: stDate
                and CloseDate <: endDate
                and AccountId In: accountids
                GROUP BY AccountId
            ]) {
            oppAmountCloseWonMap.put((Id) ar.get('aId'), (Decimal) ar.get('sum')==null?0:(Decimal) ar.get('sum'));
        }

        // -1 year
        Map < Id, Decimal > oppAmountCloseWonMap_1year = new Map < Id, Decimal > ();
        for (AggregateResult ar: [SELECT AccountId aId, SUM(Amount) sum
                from opportunity where IsClosed = true and IsWon = True
                and CloseDate >=: stDate.addYears(-1)
                and CloseDate <: endDate.addYears(-1)
                and AccountId In: accountids
                GROUP BY AccountId
            ]) {
            oppAmountCloseWonMap_1year.put((Id) ar.get('aId'), (Decimal) ar.get('sum')==null?0:(Decimal) ar.get('sum'));
        }
        // -2 year
        Map < Id, Decimal > oppAmountCloseWonMap_2year = new Map < Id, Decimal > ();
        for (AggregateResult ar: [SELECT AccountId aId, SUM(Amount) sum
                from opportunity where IsClosed = true and IsWon = True
                and CloseDate >=: stDate.addYears(-2)
                and CloseDate <: endDate.addYears(-2)
                and AccountId In: accountids
                GROUP BY AccountId
            ]) {
            oppAmountCloseWonMap_2year.put((Id) ar.get('aId'), (Decimal) ar.get('sum')==null?0:(Decimal) ar.get('sum'));
        }

        Map < Id, Decimal > unitPerForecastMap = new Map < Id, Decimal > ();
        Map < Id, Decimal > projectAmountPerForecastMap = new Map < Id, Decimal > ();

        Map < id, Decimal > budgetUnitsForecastMap = new Map < Id, Decimal > ();
        Map < id, Decimal > budgetSalesForecastMap = new Map < Id, Decimal > ();

        // Map For sum Of (Units) and (Projected Amount) for Account Yearly Forecast
        for (AggregateResult ar: [SELECT Account_Yearly_Forecast__r.Account__r.id AId,
                SUM(Units__c) uSum,
                SUM(Projected_Amount__c) pSum,
                SUM(Budgeted_Units__c) b_unitSum,
                SUM(Budgeted_Sales__c) b_salesSum
                FROM Forecast_Product_Category__c
                WHERE Account_Yearly_Forecast__r.Account__r.id IN: accountids and
                Account_Yearly_Forecast__r.Forecast_Period_Start__c >=: stDate
                and Account_Yearly_Forecast__r.Forecast_Period_Start__c <: endDate
                GROUP BY Account_Yearly_Forecast__r.Account__r.id
            ]) {
            unitPerForecastMap.put((Id) ar.get('AId'), (Decimal) ar.get('uSum')==null?0:(Decimal) ar.get('uSum'));
            projectAmountPerForecastMap.put((Id) ar.get('AId'), (Decimal) ar.get('pSum')==null?0:(Decimal) ar.get('pSum'));
            budgetUnitsForecastMap.put((Id) ar.get('AId'), (Decimal) ar.get('b_unitSum')==null?0:(Decimal) ar.get('b_unitSum'));
            budgetSalesForecastMap.put((Id) ar.get('AId'), (Decimal) ar.get('b_salesSum')==null?0:(Decimal) ar.get('b_salesSum'));
        }


        for (Account a: [select id, Name, ownerid from account where Include_in_Forecast__c = true and ownerid in: currentUserSubordinatesIds]) {
            AccountWrapper temp = new AccountWrapper();
            temp.accId = a.id;
            temp.accName = a.name;

            temp.forecast = ((accountId_AYFobj_Map.ContainsKey(a.id)) ? (accountId_AYFobj_Map.get(a.id)) : (new Account_Yearly_Forecast__c()));

            temp.Forecast_Status = temp.forecast.Forecast_Status__c == null ? 'Not Provided' : temp.forecast.Forecast_Status__c;
            temp.sortDirection = sortDirection;
            temp.currentField = currentField;

            temp.openSum = oppAmountOpenMap.containsKey(a.id) ? oppAmountOpenMap.get(a.id) : 0.0;
            temp.cwSum = oppAmountCloseWonMap.containsKey(a.id) ? oppAmountCloseWonMap.get(a.id) : 0.0;
            temp.cwSum_1year = oppAmountCloseWonMap_1year.containsKey(a.id) ? oppAmountCloseWonMap_1year.get(a.id) : 0.0;
            temp.cwSum_2year = oppAmountCloseWonMap_2year.containsKey(a.id) ? oppAmountCloseWonMap_2year.get(a.id) : 0.0;

            temp.unitSum = unitPerForecastMap.containsKey(a.id) ? (unitPerForecastMap.get(a.id) == null ? 0.0 : unitPerForecastMap.get(a.id)) : 0.0;
            temp.pAmountSum = projectAmountPerForecastMap.containsKey(a.id) ? (projectAmountPerForecastMap.get(a.Id) == null ? 0.0 : projectAmountPerForecastMap.get(a.Id)) : 0.0;

            temp.budget_unitSum = budgetUnitsForecastMap.containsKey(a.id) ? (budgetUnitsForecastMap.get(a.id) == null ? 0.0 : budgetUnitsForecastMap.get(a.id)) : 0.0;
            temp.budget_SalesSum = budgetSalesForecastMap.containsKey(a.id) ? (budgetSalesForecastMap.get(a.id) == null ? 0.0 : budgetSalesForecastMap.get(a.id)) : 0.0;
            UserId_AccountList_Map.get(a.ownerid).add(temp);
        }
        totalsByUser();
        for (id i: UserId_AccountList_Map.keyset()) {
            /*List < AccountWrapper > temp = new List < AccountWrapper >();
            for(AccountWrapper a:UserId_AccountList_Map.get(i)){
                a.sortDirection=sortDirection;
                a.currentField=currentField;
                temp.add(a);
            }
            UserId_AccountList_Map.put(i,temp);*/
            UserId_AccountList_Map.get(i).sort();
        }
    }

    public void totalsByUser() {
        //try {
            set < id > tempUserIds = new set < id > ();
            for (selectOption i: userHierarchy) {
                tempUserIds.add(i.getValue());
            }
            if (tempUserIds.size() > 0) {
                for (id i: tempUserIds) {
                    AccountWrapper aw = new AccountWrapper();
                    for (id us: UserId_SalesRep_subordinate_Map.get(i)) {
                        for (AccountWrapper awone: UserId_AccountList_Map.get(us)) {
                            aw.pAmountSum += awone.pAmountSum;
                            aw.unitSum += awone.unitSum;
                            aw.openSum += awone.openSum;
                            aw.cwSum += awone.cwSum;

                            aw.cwSum_1year += awone.cwSum_1year;
                            aw.cwSum_2year += awone.cwSum_2year;

                            aw.budget_unitSum += awone.budget_unitSum;
                            aw.budget_SalesSum += awone.budget_SalesSum;
                        }
                    }
                    UserId_Totals.put(i, aw);
                }
            }
            if (tempUserIds.size() > 0) {
                for (id i: tempUserIds) {
                    AccountWrapper aw = new AccountWrapper();
                    for (AccountWrapper awone: UserId_AccountList_Map.get(i)) {
                        aw.pAmountSum += awone.pAmountSum;
                        aw.unitSum += awone.unitSum;
                        aw.openSum += awone.openSum;
                        aw.cwSum += awone.cwSum;

                        aw.cwSum_1year += awone.cwSum_1year;
                        aw.cwSum_2year += awone.cwSum_2year;

                        aw.budget_unitSum += awone.budget_unitSum;
                        aw.budget_SalesSum += awone.budget_SalesSum;
                    }
                    UserId_ownTotals.put(i, aw);
                }
            }
        //} catch (Exception e) {
        //    System.debug(e.getCause() + ' ' + e.getLineNumber() + ' ' + e.getMessage() + ' ' + e.getStackTraceString());
        //}

    }

    public pagereference dateChange() {
        try{
            integer day = Integer.valueOf(defaultDateTest.subString(0, 2));
            integer month = Integer.valueOf(defaultDateTest.subString(3, 5));
            integer year = Integer.valueOf(defaultDateTest.subString(6, 10));
            defaultDate = date.newinstance(year, month, day);
            stDate = Date.newInstance(defaultDate.year(), 1, 1); //+1
            endDate = Date.newInstance(defaultDate.year() + 1, 1, 1); //+2
            defaultDateTest = '01/01/' + defaultDate.year();
            this.year=stDate.year();
            setFilter();
            if(currentYear==stDate.year()||currentYear==stDate.year()-1||currentYear==stDate.year()+1)
            isShowDateField=true;
            update new user(id = UserInfo.getUserId(), Forecast_Year__c=this.year);

        }catch(Exception e){
            System.debug(e.getCause() + ' ' + e.getLineNumber() + ' ' + e.getMessage() + ' ' + e.getStackTraceString());
        }
        return null;
    }
    public pagereference customDateChange(){
        defaultDateTest = '01/01/'+(System.today().year()+2);  
        System.debug(defaultDateTest);  
        isShowDateField=false;
        dateChange();
        return null;
    }
    global class AccountWrapper implements Comparable {
        public Id accId {    get;set;}
        public String accName {get;set;}
        public Account_Yearly_Forecast__c forecast {get;set;}
        public String Forecast_Status {get;set;}
        public Decimal cwSum_2year {get;set;}
        public Decimal cwSum_1year {get;set;}
        public Decimal pAmountSum {get;set;}
        public Decimal cwSum {get;set;}
        public Decimal openSum {get;set;}
        public String currentField {get;set;}
        public String sortDirection {get;set;}
        //-------------------------------//
        public Decimal unitSum {get;set;}
        public decimal budget_unitSum {get;set;}
        public decimal budget_SalesSum {get;set;}
        //-------------------------------//
        public AccountWrapper() {
            forecast = new Account_Yearly_Forecast__c();
            pAmountSum = 0.0;
            openSum = 0.0;
            cwSum = 0.0;

            cwSum_1year = 0.0;
            cwSum_2year = 0.0;

            unitSum = 0.0;
            budget_unitSum = 0.0;
            budget_SalesSum = 0.0;

            currentField = 'accName';
            sortDirection = 'asc';
        }
        global Integer CompareTo(Object compareTo) { if (currentField == 'accName') { System.debug('Account Name'); AccountWrapper temp = (AccountWrapper) compareTo; if (accName == temp.accName) return 0; if (sortDirection == 'asc') { System.debug('asc'); if (accName > temp.accName) return 1; return -1; } else { System.debug('desc'); if (accName < temp.accName) return 1; return -1; } } else if (currentField == 'Forecast_Status') { AccountWrapper temp = (AccountWrapper) compareTo; if (Forecast_Status == temp.Forecast_Status) return 0; if (sortDirection == 'asc') { if (Forecast_Status > temp.Forecast_Status) return 1; return -1; } else { if (Forecast_Status < temp.Forecast_Status) return 1; return -1; } } else if (currentField == 'cwSum_2year') { AccountWrapper temp = (AccountWrapper) compareTo; if (cwSum_2year == temp.cwSum_2year) return 0; if (sortDirection == 'asc') { if (cwSum_2year > temp.cwSum_2year) return 1; return -1; } else { if (cwSum_2year < temp.cwSum_2year) return 1; return -1; } } else if (currentField == 'cwSum_1year') { AccountWrapper temp = (AccountWrapper) compareTo; if (cwSum_1year == temp.cwSum_1year) return 0; if (sortDirection == 'asc') { if (cwSum_1year > temp.cwSum_1year) return 1; return -1; } else { if (cwSum_1year < temp.cwSum_1year) return 1; return -1; } } else if (currentField == 'pAmountSum') { AccountWrapper temp = (AccountWrapper) compareTo; if (pAmountSum == temp.pAmountSum) return 0; if (sortDirection == 'asc') { if (pAmountSum > temp.pAmountSum) return 1; return -1; } else { if (pAmountSum < temp.pAmountSum) return 1; return -1; } } else if (currentField == 'cwSum') { AccountWrapper temp = (AccountWrapper) compareTo; if (cwSum == temp.cwSum) return 0; if (sortDirection == 'asc') { if (cwSum > temp.cwSum) return 1; return -1; } else { if (cwSum < temp.cwSum) return 1; return -1; } } else if (currentField == 'openSum') { AccountWrapper temp = (AccountWrapper) compareTo; if (openSum == temp.openSum) return 0; if (sortDirection == 'asc') { if (openSum > temp.openSum) return 1; return -1; } else { if (openSum < temp.openSum) return 1; return -1; } } return 0; }
    }
    public pagereference updateSortDirection() {
        if (currentField == previousField) {
            if (sortDirection == 'asc') {
                sortDirection = 'desc';
            } else if (sortDirection == 'desc') {
                System.debug('2');
                sortDirection = 'asc';
            }
        }
        previousField = currentField;
        update new user(id = UserInfo.getUserId(), Forecast_Sort__c = sortDirection, Forecast_Sort_Field__c = currentField);
        for (id i: UserId_AccountList_Map.keyset()) {
            List < AccountWrapper > temp = new List < AccountWrapper > ();
            for (AccountWrapper a: UserId_AccountList_Map.get(i)) {
                a.sortDirection = sortDirection;
                a.currentField = currentField;
                temp.add(a);
            }
            UserId_AccountList_Map.put(i, temp);
            UserId_AccountList_Map.get(i).sort();
        }
        return null;
    }
     public void update_AYF(){
        for(AccountWrapper a:UserId_AccountList_Map.get(userId)){
            if(a.forecast.id==ayf_Id){
                try{update a.forecast;}catch(exception e){}
                break;
            }
        }
    }
    public Id ayf_Id{get;set;}
    public id userId{get;set;}
}