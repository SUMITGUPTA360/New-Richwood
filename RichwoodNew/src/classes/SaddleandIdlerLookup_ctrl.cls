public class SaddleandIdlerLookup_ctrl {
    public List<Selectoption> beltWidthOptions{get;set;}
    public List<Selectoption> troughAngleOptions{get;set;}
    public List<Selectoption> materialOptions{get;set;}
    
    
    public list<fractionWrapper> fractionWrapperList{get;set;}
    
    public Saddle__c saddle{get;set;}
    
    // Start Excel sheet Data Variables
    public decimal BC {get;set;}
    public decimal Belt_Speed {get;set;}
    public decimal BW {get;set;}
    public decimal Center_Height {get;set;}
    public decimal CH {get;set;}
    public decimal Chord_Length {get;set;}
    public decimal CL {get;set;}
    public decimal Drop_Height {get;set;}
    public decimal Material_Density {get;set;}
    public decimal MAX_Lump_Size {get;set;}
    public decimal MAX_Lump_Weight {get;set;}
    public decimal PCH {get;set;}
    public decimal PCL {get;set;}
    public decimal PWH {get;set;}
    public decimal TA {get;set;}
    public decimal TA_D {get;set;}
    public decimal Tons_per_Hour {get;set;}
    public decimal Trough_Angle {get;set;}
    public decimal WH {get;set;}
    public decimal Wing_Height {get;set;}
    public String IdlerInLoadZone{get;set;}
    // END  Excel sheet Data Variables
    
    public integer v63{get;set;}//Based on excelsheet
    public integer v64{get;set;}//Based on excelsheet
    public integer v65{get;set;}//Based on excelsheet
    
    public decimal ChordLength20{get;set;}
    public decimal ChordLength35{get;set;}
    public decimal ChordLength45{get;set;}
    
    public decimal WingHeight20{get;set;}
    public decimal WingHeight35{get;set;}
    public decimal WingHeight45{get;set;}
    
    public decimal CenterHeight{get;set;}
    
    public map<string,Specifications_Data_Base__c> ChordLength_SDB_Map{get;set;}
    
    
    //public decimal CenterHeight_sph{get;set;}
    
    
    //circle varibales
    public decimal a{get;set;}
    public decimal a2{get;set;}
    
    public decimal b{get;set;}
    public decimal b2{get;set;}
    
    public decimal c{get;set;}
    public decimal c2{get;set;}
    
    public decimal d{get;set;}
    public decimal d2{get;set;}
    
    public decimal e{get;set;}
    public decimal e2{get;set;}
    
    public decimal f{get;set;}
    public decimal f2{get;set;}
    
    public decimal h{get;set;}
    public decimal k{get;set;}
    public decimal r{get;set;}
    public decimal r2{get;set;}
    public boolean h_err{get;set;}//Need to remove/Delete
    
    public decimal y01{get;set;}
    public decimal y0S{get;set;}
    public decimal y20{get;set;}
    public decimal y35{get;set;}
    public decimal y45{get;set;}
    
    //Angle Equations
    public decimal Idler0_sin{get;set;}
    public decimal Idler0_deg{get;set;}
    public decimal Saddle0_sin{get;set;}
    public decimal Saddle0_deg{get;set;}
    public decimal AE20_sin{get;set;}
    public decimal AE20_deg{get;set;}
    public decimal AE35_sin{get;set;}
    public decimal AE35_deg{get;set;}
    public decimal AE45_sin{get;set;}
    public decimal AE45_deg{get;set;}
    
    public decimal saddleIncrements20{get;set;}
    public decimal IdlerIncrements20{get;set;}
    public decimal Increments20_35{get;set;}
    public decimal Increments35_45{get;set;}
    
    
    public decimal NewSaddleAngle{get;set;}
    public decimal NewIdlerAngle{get;set;}
    public decimal NewSaddleChord{get;set;}
    public decimal NewIdlerChord{get;set;}
    public decimal NewSaddleWingHeight{get;set;}
    public decimal NewIdlerWingHeight{get;set;}
    
    public decimal y59{get;set;}
    public decimal Y61{get;set;}
    
    //SPH variables
    public decimal CenterHeight_sph{get;set;}
    public decimal WingHeight_sph{get;set;}
    public decimal ChordLength_sph{get;set;}
    public decimal SealPoint_sph{get;set;}
    public decimal tan_sph{get;set;}
    public decimal cos_sph{get;set;}
    public decimal sin_sph{get;set;}
    public decimal y2_sph {get;set;}
    public decimal x_sph{get;set;}
    public decimal y_sph{get;set;}
    public decimal PoTChord_sph{get;set;}
    public decimal B_sph{get;set;}
    public decimal Ysp_sph{get;set;}
    public decimal Y1_sph{get;set;}
    public decimal r_sph{get;set;}
    public decimal r2_sph{get;set;}
    public decimal Yasp_sph{get;set;}
    public string SealLocation_sph{get;set;}
    public decimal SealHeight_sph{get;set;}
    
    
    public string T77{get;set;}
    public string T78{get;set;}
    public string T79{get;set;}

    public string message1{get;set;}
    public string message2{get;set;}
    public string message3{get;set;}
    
    public boolean isMobile{get;set;}
    
    public boolean isError{get;set;}
    
    public boolean isEditMode{get;set;}
    
    public opportunity newOpp{get;set;}
    public boolean selectJoin{get;set;}
    public boolean isnewOpp{get;set;}
    public boolean isexisting{get;set;}
    public boolean isoppBtns{get;set;}
    public ApexPages.StandardController controller{get;set;}
    
    public list<Selectoption> AssetOptions{get;set;}
    
    public SaddleandIdlerLookup_ctrl(ApexPages.StandardController controller) {
        selectJoin=false;
        isnewOpp=false;
        isexisting=false;
        isoppBtns=false;
        newOpp = new opportunity();
        isEditMode=true;
        this.controller=controller;
        //isError=false;
        ChordLength_SDB_Map = new map<string,Specifications_Data_Base__c>();
        isMobile=(UserInfo.getUiTheme() == 'Theme4t')?true:false;
        //isMobile=true;
        v63=20;
        v64=35;
        v65=45;
        
        y59=20;
        y61=35;
        
        T77='ASR';
        T78='SWR';
        T79='ARR';
        
        fractionWrapperList = new list<fractionWrapper>();
        fractionWrapperList.add(new fractionWrapper('1/16','0.0625'));
        fractionWrapperList.add(new fractionWrapper('1/8','0.125'));
        fractionWrapperList.add(new fractionWrapper('3/16','0.1875'));
        fractionWrapperList.add(new fractionWrapper('1/4','0.25'));
        fractionWrapperList.add(new fractionWrapper('5/16','0.3125'));
        fractionWrapperList.add(new fractionWrapper('3/8','0.375'));
        fractionWrapperList.add(new fractionWrapper('7/16','0.4375'));
        fractionWrapperList.add(new fractionWrapper('1/2','0.5'));
        fractionWrapperList.add(new fractionWrapper('9/16','0.5625'));
        fractionWrapperList.add(new fractionWrapper('5/8','0.625'));
        fractionWrapperList.add(new fractionWrapper('11/16','0.6875'));
        fractionWrapperList.add(new fractionWrapper('3/4','0.75'));
        fractionWrapperList.add(new fractionWrapper('13/16','0.8125'));
        fractionWrapperList.add(new fractionWrapper('7/8','0.875'));
        fractionWrapperList.add(new fractionWrapper('15/16','0.9375'));
                
        beltWidthOptions = new List<selectoption>{new selectOption('', '')};
        for(integer i=24;i<=96;i=i+6){
             beltWidthOptions.add(new SelectOption(''+i,i+''));
        }
        troughAngleOptions = new List<selectoption>{new selectOption('', '')};
            troughAngleOptions.add(new SelectOption(''+25,25+''));
            troughAngleOptions.add(new SelectOption(''+35,35+''));
            troughAngleOptions.add(new SelectOption(''+45,45+''));
        for(integer i=4;i<=45;i=i+1){
                if(i==25||i==35||i==45||i==2||i==3||i==4)continue;
             troughAngleOptions.add(new SelectOption(''+i,i+''));
        }
      
        materialOptions = new List<selectoption>{new selectOption('', '')};
        for(Specifications_Data_Base__c sdb:[SELECT id,Name,Material__c,Density__c,
                                                    BW_TA__c,Program_CH__c,Program_WH__c,Program_CL__c
                                             FROM Specifications_Data_Base__c 
                                             /*WHERE Material__c!=null*/ ORDER BY Material__c]){
             if(sdb.Material__c!=null)                                    
             materialOptions.add(new SelectOption(''+sdb.Material__c,sdb.Material__c+''));//sdb.Density__c
                                                 
             //-------------------------------//
             if(sdb.BW_TA__c!=null)
                 ChordLength_SDB_Map.put((sdb.BW_TA__c+''),sdb);
             //-------------------------------//                                    
        }
        saddle = new saddle__c(Units__c='Standard',Idler_in_Load_Zone__c='Yes');
        
        //Initialize Excel varibales
        //TA = 0;
        //initialize();//----need to think
        
        //Material_Density if empty consider as Zero******************************
    }
    public pagereference unload(){
        System.debug((Saddle__c) controller.getRecord());
        if(((Saddle__c) controller.getRecord()).id==null){
            /*Saddle__c stemp = new Saddle__c();
            insert stemp;
            saddle=[SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, LastActivityDate, SystemModstamp, LastViewedDate, LastReferencedDate, Units__c, Belt_Width__c, Belt_Speed__c, Tons_per_Hour__c, MAX_Lump_Size__c, Drop_Height__c, Bolt_Centers__c, Trough_Angle__c, Center_Height__c, Wing_Height__c, Chord_Length__c, Saddle__c, Dimension_B__c, Dimension_A__c, Dimension_C__c, Dimension_D__c, Dimension_E__c, Idler__c, Dimension_F__c, Material__c, Idler_in_Load_Zone__c, MAX_Lump_Weight__c, Material_Density__c FROM Saddle__c 
                where id=:stemp.id limit 1];
            */
        }else{
            saddle=(Saddle__c) controller.getRecord();
            System.debug(saddle);
            saddle=[SELECT Id, OwnerId, IsDeleted, Name,Asset__c,Customer_Asset__c, CreatedDate,Opportunity__c, Units__c, Belt_Width__c, Belt_Speed__c, Tons_per_Hour__c, MAX_Lump_Size__c, Drop_Height__c, Bolt_Centers__c, Trough_Angle__c, Center_Height__c, Wing_Height__c, Chord_Length__c, Saddle__c, Dimension_B__c, Dimension_A__c, Dimension_C__c, Dimension_D__c, Dimension_E__c, Idler__c, Dimension_F__c, Material__c, Idler_in_Load_Zone__c, MAX_Lump_Weight__c, Material_Density__c FROM Saddle__c 
                where id=:saddle.id limit 1];
            initialize(); 
        }
        
        return null;
    }
    public pagereference initialize(){try{
        /*if(saddle.id==null){
            System.debug('---');
            insert saddle;
            saddle=[SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, LastActivityDate, SystemModstamp, LastViewedDate, LastReferencedDate, Units__c, Belt_Width__c, Belt_Speed__c, Tons_per_Hour__c, MAX_Lump_Size__c, Drop_Height__c, Bolt_Centers__c, Trough_Angle__c, Center_Height__c, Wing_Height__c, Chord_Length__c, Saddle__c, Dimension_B__c, Dimension_A__c, Dimension_C__c, Dimension_D__c, Dimension_E__c, Idler__c, Dimension_F__c, Material__c, Idler_in_Load_Zone__c, MAX_Lump_Weight__c, Material_Density__c FROM Saddle__c 
                where id=:saddle.id limit 1];
        }*/
        //isError=false;
        DataVaraibles();
            
       //calculated values from user entered values
       decimal WingHeight=saddle.Units__c=='Standard'?
                           saddle.Wing_Height__c:(saddle.Wing_Height__c==null?saddle.Wing_Height__c:
                                                  (saddle.Wing_Height__c/25.4)
                                                 );
                                                     
        
        
        
        
        CircleEquations();
        AngleEquations();
        Saddle_Idler_Increments();
        newSaddlerIdler();
        PCL=NewIdlerChord;//-----------------------
        ProgramLayoutSealPointHeights();
        
        SaddleName();
        IdlerName();
        HeightOfOldIdler();
        HeightofNewIdlerSealHeight();
        someVariables();
        GivensStandard();
        
        saddle.Dimension_F__c=TA_D==0?'':TA_D+'';
       //Saddle.Saddle__c 
       if(!isError){
            Saddle.Saddle__c=(AQ65 == 0?
                                        (Willbothunitswork == 'Yes'?
                                                        ((CH>CenterHeight||CH==CenterHeight)?
                                                                (program == 'Yes'?
                                                                   'Series R ~ ' +AO36:
                                                                    'Send to engineering for custom series R Saddle'):
                                                            'Low center height. Send to engineering.'):
                                           'Send to engineering for review'):
                                'Need more Information');
       }else{
           Saddle.Saddle__c='Need more Information';          
       }
       //Saddle.Idler__c
       //AV72:Willbothunitswork W72:CenterHeight
        if(!isError){
            Saddle.Idler__c=(AQ66 == 0?
                                (Willbothunitswork == 'Yes'?
                                    ((CH>CenterHeight||CH==CenterHeight)?
                                            (program == 'Yes'?
                                                'Series R ~ ' +AO43:
                                                'Send to engineering for custom series R Saddle'):
                                            'Low center height. Send to engineering.'):
                                    'Send to engineering for review'):
                               'Need more Information');
        }else{
            Saddle.Idler__c='Need more Information';          
        } 
        if(Saddle.Saddle__c=='Need more Information'){
            Saddle.Dimension_A__c='';
        }else{
            Saddle.Dimension_A__c=BC+'';
        }
        
        if(Saddle.Dimension_A__c==''){
            Saddle.Dimension_B__c='';
        }else{
            Saddle.Dimension_B__c=(BC+2)+'';
        }
        
        if(Saddle.Saddle__c=='Need more Information'){
            Saddle.Dimension_C__c='';
        }else{
            Saddle.Dimension_C__c=(PCH+ExtraHeight)+'';
        }
        
        if(Saddle.Saddle__c=='Need more Information'){
            Saddle.Dimension_D__c='';
        }else{
            Saddle.Dimension_D__c=((((PWH+ExtraHeight)*16).setscale(0))/16)+'';
        }
        //=IF(J5= "Need more Information","",ROUND(PCL*16,0)/16)
        if(Saddle.Saddle__c=='Need more Information'){
            Saddle.Dimension_E__c='';
        }else{
            Saddle.Dimension_E__c=((((PCL)*16).setscale(0))/16)+'';
        }    
        /*message1=(AQ65==1?'':
                     (
                         ISERROR(
                             (program=='Yes'?
                                (Difference<0.4375?
                                   '':
                                   '*Consider raising Center Height*'):
                                (Difference>0?
                                   '*Consider raising Center Height*':
                                   '*Consider Lowering Center Height*'
                                  )))
                         ?'':
                         (program=='Yes'?
                            (Difference<0.4375?
                               '':
                               '*Consider raising Center Height*'
                              ):
                            (Difference>0?
                               '*Consider raising Center Height*':
                               '*Consider Lowering Center Height*'))));     
        */
        
        
           
            
            message1='';
            if(AQ65==1){
                message1='';
            }else{
                boolean message1error=false;
                try{
                        message1=(program=='Yes'?(Difference<0.4375?'':'Program 2/3 Belt Width Height is '+Distance+' Shorter'):
                            (Difference<0?'Program 2/3 Belt Width Height is '+Distance.setscale(4)+' Taller':
                     'Program 2/3 Belt Width Height is '+Distance+' Shorter'));
                            
                            
                }catch(Exception message1errorex){
                    message1error=true;
                }
                if(message1error){
                    message1='';
                }
            }    
            message2='';
            if(AQ65==1){
                message2='';
            }else{
                boolean message2error=false;
                try{
                    message2=(program=='Yes'?(Difference<0.4375?'':'*Consider raising Center Height*'):
                   (Difference>0?'*Consider raising Center Height*':'*Consider Lowering Center Height*'));
                        
                }catch(Exception message2exp){
                    message2error=true;
                }
                if(message2error){
                    message2='';
                }
            }
        
        if(isError){
            message3='';    
        }else{
            message3=(program=='Yes'?(MinClearanceNeeded==0?'':'Required minimum clearance below top of structure is '+MinClearanceNeeded + ''):'');
        }
        /*if(saddle.id!=null)
        update saddle;*/
    }catch(exception e){
        
    }
        return null;
    }
    public class fractionWrapper{
        public string fraction{get;set;}
        public string fractionNumber{get;set;}
        public fractionWrapper(string fraction, string fractionNumber){
            this.fraction=fraction;
            this.fractionNumber=fractionNumber;
        }
    }
    public void DataVaraibles(){
        System.debug(saddle.Belt_Width__c);
        
        BC=saddle.Units__c=='Standard'?(saddle.Bolt_Centers__c==null?0:saddle.Bolt_Centers__c):(saddle.Bolt_Centers__c==null?0:(saddle.Bolt_Centers__c/25.4));
        Belt_Speed=saddle.Units__c=='Standard'?(saddle.Belt_Speed__c==null?0:saddle.Belt_Speed__c):(saddle.Belt_Speed__c==null?0:(saddle.Belt_Speed__c/0.00508));
        BW=saddle.Units__c=='Standard'?(saddle.Belt_Width__c==null?0:saddle.Belt_Width__c):(saddle.Belt_Width__c==null?0:(saddle.Belt_Width__c/25.4));
        CH=saddle.Units__c=='Standard'?(saddle.Center_Height__c==null?0:saddle.Center_Height__c):(saddle.Center_Height__c==null?0:(saddle.Center_Height__c/25.4));
        CL=saddle.Units__c=='Standard'?(saddle.Chord_Length__c==null?0:saddle.Chord_Length__c):(saddle.Chord_Length__c==null?0:(saddle.Chord_Length__c/25.4)); 
        Drop_Height   = saddle.Drop_Height__c==null?0:saddle.Drop_Height__c;
        
        List<Specifications_Data_Base__c> Material_DensityList = new list<Specifications_Data_Base__c>();
        if(saddle.Material_Density__c!=null){
            Material_DensityList.addall([select id,Material__c,Density__c from Specifications_Data_Base__c where Material__c=:saddle.Material_Density__c ]);
        }
        Material_Density=Material_DensityList.size()==0?0:Material_DensityList[0].Density__c;
        
        saddle.MAX_Lump_Size__c = saddle.MAX_Lump_Size__c==null?0:saddle.MAX_Lump_Size__c;
        MAX_Lump_Size=saddle.MAX_Lump_Size__c;
        
        saddle.MAX_Lump_Weight__c=saddle.MAX_Lump_Weight__c==null?0:saddle.MAX_Lump_Weight__c;
        MAX_Lump_Weight=saddle.MAX_Lump_Weight__c;
        
        TA=saddle.Trough_Angle__c==null?0:(saddle.Trough_Angle__c* (Math.PI/180));    
        TA_D=saddle.Trough_Angle__c==null?0:saddle.Trough_Angle__c;
        Tons_per_Hour=saddle.Units__c=='Standard'?(saddle.Tons_per_Hour__c==null?0:saddle.Tons_per_Hour__c):(saddle.Tons_per_Hour__c==null?saddle.Tons_per_Hour__c:(saddle.Tons_per_Hour__c/0.90718474));
        WH=saddle.Units__c=='Standard'?(saddle.Wing_Height__c==null?0:saddle.Wing_Height__c):(saddle.Wing_Height__c==null?0:(saddle.Wing_Height__c/25.4));                                                
        
            
        IdlerInLoadZone=saddle.Idler_in_Load_Zone__c=='Yes'?'SWR':'ASR';    
        isError=false; 
        tableLookup();
        if(!isError){
            PCH=CenterHeight;
            /*
                
                =PCL
                =PWH
            */    
        }
    }
    public void tableLookup(){
        try{
        v63=Integer.valueOf(BW+''+20);
        v64=Integer.valueOf(BW+''+35);
        v65=Integer.valueOf(BW+''+45);
        
        ChordLength20=ChordLength_SDB_Map.get((v63+'.00')).Program_CL__c;
        ChordLength35=ChordLength_SDB_Map.get((v64+'.00')).Program_CL__c;
        ChordLength45=ChordLength_SDB_Map.get((v65+'.00')).Program_CL__c;
        
        WingHeight20=ChordLength_SDB_Map.get((v63+'.00')).Program_WH__c;
        WingHeight35=ChordLength_SDB_Map.get((v64+'.00')).Program_WH__c;
        WingHeight45=ChordLength_SDB_Map.get((v65+'.00')).Program_WH__c;    
        CenterHeight=ChordLength_SDB_Map.get((v63+'.00')).Program_CH__c;
        }catch(exception e){
            isError=true;
        }
    }
    
    public void CircleEquations(){
        try{
            a=ChordLength20/2;
            a2=a*a;
            
            b=WingHeight20;
            b2=b*b;
            
            c=ChordLength35/2;
            c2=c*c;
            
            d=WingHeight35;
            d2=d*d;
            
            e=ChordLength45/2;
            e2=e*e;
            
            f=WingHeight45;
            f2=f*f;
            
            decimal t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;
            t1=(a2+b2); t2=(f-d); t3=(c2+d2); t4=(b-f); t5=(e2+f2); t6=(d-b); t7=(f-d); t8=(d-b); t9=(b-f); t10=(d-b); 
            t11=(t1*t2)+(t3*t4)+(t5*t6);
            t12=(a*t7)+(c*t9)+(e*t10);
            h=(.5*(t11/t12));
            
            
            //h=(1/2)*((a2+b2)*(f-d)+(c2+d2)*(b-f)+(e2+f2)*(d-b))/(a*(f-d)+c*(b-f)+e*(d-b));
            
            t1=(a2+b2);t2=(e-c);t3=(c2+d2);t4=(a-e);t5=(e2+f2);t6=(c-a);t7=(e-c);t8=(a-e);t9=(c-a);
            t10=(t1*t2)+(t3*t4)+(t5*t6); t11=(b*t7)+(d*t8)+(f*t9);
            k=(.5*(t10/t11));
            //K=(1/2)*((a2+b2)*(e-c)+(c2+d2)*(a-e)+(e2+f2)*(c-a))/(b*(e-c)+d*(a-e)+f*(c-a));
            System.debug(h+'  '+k);
            
            t1=(a-h);t2=(a-h);t3=(b-k);t4=(b-k);
            r2=(t1*t2)+(t3*t4);
            //((a-h)*(a-h))+((b-k)*(b-k));
            r=math.sqrt(r2);
            
            y01=CenterHeight-k;
            y0S=CenterHeight-0.25-k;
            y20=b-k;
            y35=d-k;
            y45=f-k;
            
        }catch(Exception e){
            System.debug(e);
            isError=true;
        }
    }
    public void AngleEquations(){
        try{
            Idler0_sin=Math.ASIN(y01/r);
            Idler0_deg=Idler0_sin * (180/Math.pi);
            Saddle0_sin=Math.ASIN(y0S/r);
            Saddle0_deg=Saddle0_sin* (180/Math.pi);
            AE20_sin=Math.ASIN(y20/r);
            AE20_deg=AE20_sin* (180/Math.pi);
            AE35_sin=Math.ASIN(y35/r);
            AE35_deg=AE35_sin* (180/Math.pi);
            AE45_sin=Math.ASIN(y45/r);
            AE45_deg=AE45_sin* (180/Math.pi);
        }catch(Exception e){
            isError=true;
        }
    }
    public void Saddle_Idler_Increments(){
        try{
            saddleIncrements20=(AE20_deg-Saddle0_deg)/20;
            IdlerIncrements20=(AE20_deg-Idler0_deg)/20;
            Increments20_35=(AE35_deg-AE20_deg)/15;
            Increments35_45=(AE45_deg-AE35_deg)/10;
        }catch(Exception e){
            isError=true;
        }
    }
    public void newSaddlerIdler(){
        try{
            decimal temp1,temp2,temp3,temp4,temp5;
            temp1=saddleIncrements20*TA_D;temp2=TA_D-Y59;temp3=Increments20_35*temp2; temp4=TA_D-Y61;temp5=Increments35_45*temp4;
            
            NewSaddleAngle=TA_D<20?(Saddle0_deg+temp1):(TA_D<35?(AE20_deg+temp3):(AE35_deg+temp5));
            //IF(TA<20,(Saddle0_deg+saddleIncrements20*TA),IF(TA<35,(AE20_deg+Increments20_35*(TA-Y59)),(AE35_deg+Increments35_45*(TA-Y61))));
            NewIdlerAngle=TA_D<20?(Idler0_deg+IdlerIncrements20*TA_D):(TA_D<35?(AE20_deg+Increments20_35*(TA_D-Y59)):(AE35_deg+Increments35_45*(TA_D-Y61)));
            //IF(TA<20,(Idler0_deg+IdlerIncrements20*TA),IF(TA<35,(AE20_deg+Increments20_35*(TA-Y59)),(AE35_deg+Increments35_45*(TA-Y61))));
            NewSaddleChord=(r*Math.COS(NewSaddleAngle* (Math.pi/180))+h)*2; 
            NewIdlerChord=(r*Math.COS(NewIdlerAngle* (Math.pi/180))+h)*2;
            NewSaddleWingHeight=r*Math.SIN(NewSaddleAngle* (Math.pi/180))+k;
            
            temp1=(Math.pi/180)*NewIdlerAngle;
            NewIdlerWingHeight=r*Math.SIN(temp1)+k;
        }catch(Exception e){
            isError=true;
        }
    }
    public void ProgramLayoutSealPointHeights(){
        try{
            CenterHeight_sph=CenterHeight;    
            WingHeight_sph=NewIdlerWingHeight;
            PWH=WingHeight_sph;
            ChordLength_sph=NewIdlerChord;
            SealPoint_sph=BW/3;
            
            tan_sph=Math.tan(TA);
            cos_sph=Math.cos(TA);
            sin_sph=Math.sin(TA);
            
            
            B_sph=PWH-Math.TAN(TA)*(PCL/2);
            y2_sph=((cos_sph*B_sph)+PCH)/(1+cos_sph);
            y1_sph=(Math.COS(TA)*B_sph-PCH)/(-1+Math.COS(TA));
            x_sph=(y1_sph-B_sph)/(tan_sph+(cos_sph/sin_sph));
            y_sph=tan_sph*x_sph+b_sph;
            PoTChord_sph=x_sph*2;
            Ysp_sph=Math.TAN(TA)*(BW/3)+b_sph;
            r_sph=y1_sph-PCH;
            r2_sph=r_sph*r_sph;
            yasp_sph=-1*(Math.SQRT(r2_sph-((BW/3)*(BW/3)))-Y1_sph);
            SealLocation_sph=SealPoint_sph>x_sph?'Line':'Arc';
            SealHeight_sph=SealLocation_sph=='Line'?y_sph:Yasp_sph;

        }catch(Exception ex){
            isError=true;
            System.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
        }
    }
    public decimal AO37{get;set;}
    public decimal AO38{get;set;}
    public decimal AM38{get;set;}
    public decimal AM39{get;set;}
    public decimal AM37{get;set;}
    public string AM36{get;set;}
    public string AM35{get;set;}
    public string AO36{get;set;}
    public void SaddleName(){
        try{
            AO38=((CH*8).setScale(1))/8;
            AO37=(AO38-CenterHeight<2?CenterHeight*100:(AO38-CenterHeight<4?(CenterHeight+2)*100:(AO38-CenterHeight<6?(CenterHeight+4)*100:(CenterHeight+6)*100)));
            AM38=(AO38*100-AO37).setScale(1);
            AM39=AM38.setScale(0);
            AM37=((AO38-CenterHeight)<2?(CenterHeight*100-25):(AO38-CenterHeight<4?((CenterHeight+2)*100-25):(AO38-CenterHeight<6?(CenterHeight+4)*100-25:(CenterHeight+6)*100-25)));
            AM36=BC-BW==9?'ISC2-'+BW+''+TA_D:'ISC2-'+BW+''+TA_D+'w';
            AM35=BC-BW==9?'ISC-3992-'+BW+''+TA_D:'ISC-3992-'+BW+''+TA_D+'w';
            AO36=((BC-BW==9||BC-BW==15)?
                        (AO38<CenterHeight?'Low Centerheight':
                                (AO38==CenterHeight?AM35:(AO38<CenterHeight+2?AM36+'-'+AM39:
                                                                ((AO38==CenterHeight+2||AO38==CenterHeight+4||AO38==CenterHeight+6)?
                                                                   AM35+'-'+AM37:AM36+'-'+AM37+'-'+AM39)))):
                    'Series R ~ Non-Program Bolt Centers');
            
            
        }catch(Exception ex){
            isError=true;
            System.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
        }
    }
    public string AM42{get;set;}
    public string AM43{get;set;}
    public decimal AM44{get;set;}
    public decimal AO44{get;set;}
    public decimal AO45{get;set;}
    public string AM47{get;set;}
    public decimal AM45{get;set;}
    public decimal AM46{get;set;}
    public string AO43{get;set;}
    public void IdlerName(){
        try{
            AM42=(BC-BW==9?'IIC-3993-'+BW+''+TA_D:'IIC-3993-'+BW+''+TA_D+'w');
            AM43=(BC-BW==9?'IIC3-'+BW+''+TA_D:'IIC3-'+BW+''+TA_D+'w');
            AM44=(AO38-CenterHeight<2?CenterHeight*100:(AO38-CenterHeight<4?(CenterHeight+2)*100:(AO38-CenterHeight<6?(CenterHeight+4)*100:(CenterHeight+6)*100)));
            AO44=(AO38-CenterHeight<2?CenterHeight*100:(AO38-CenterHeight<4?(CenterHeight+2)*100:(AO38-CenterHeight<6?(CenterHeight+4)*100:(CenterHeight+6)*100)));
            AO45=AO44/100;
            AM47=(IdlerInLoadZone==T77?'S':(IdlerInLoadZone==T78?'W':(IdlerInLoadZone==T79?'R':'U')));
            AM45=(AO38*100-AO44).setScale(1);
            AM46=AM45.setScale(0);
            AO43=((BC-BW==9||BC-BW==15)?(AO38<CenterHeight?'Low Centerheight':(AO38==CenterHeight?AM42+'-'+AM47:(AO38<CenterHeight+2?AM43+'-'+AM47+'-'+AM46:((AO38==CenterHeight+2||AO38==CenterHeight+4||AO38==CenterHeight+6)?AM42+'-'+AM47+'-'+AM44:AM43+'-'+AM47+'-'+AM44+'-'+AM46)))):'Series R ~ Non-Program Bolt Centers');
        }catch(Exception ex){
            isError=true;
            System.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
        }
    }
    public decimal tanofangle{get;set;}
    public decimal Chord2{get;set;}
    public decimal beltwidthOF23 {get;set;}
    public decimal Height23{get;set;}

    public void HeightOfOldIdler(){
        try{
            tanofangle=Math.TAN((90-TA_D) * (Math.pi/180));
            System.debug(tanofangle);
            Chord2=CL/2;
            beltwidthOF23=BW/3;
            Height23=(WH/(WH*tanofangle))*beltwidthOF23-((Chord2-WH*tanofangle)/tanofangle);
        }catch(Exception ex){
            isError=true;
            System.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
        }
    }
    
    public decimal SealHeight {get;set;}
    public string BWAngle {get;set;}
    public decimal LookupStandardCH {get;set;}
    public decimal MinHeight {get;set;}
    public decimal ExtraHeight {get;set;}
    public decimal Height2_3 {get;set;}
    
    public decimal Difference {get;set;}
    public decimal Distance {get;set;}
    public string Program {get;set;}

    
    public void HeightofNewIdlerSealHeight(){
        try{
            SealHeight=SealHeight_sph;
            BWAngle=BW+''+TA_D;
            LookupStandardCH=CenterHeight;
            MinHeight=SealHeight;
            ExtraHeight=AO38-LookupStandardCH;
            Height2_3=MinHeight+ExtraHeight;
            
            Program='No';
            Difference=Height23-Height2_3;
            Distance=Difference.ABS();
            Program=(Height23-Height2_3<0.5625&&Height23-Height2_3>=-0.0625)?'Yes':'No';
        }catch(Exception ex){
            isError=true;
            Difference=null;
            Distance=null;
            System.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString());
        }
    }
    public decimal AS38{get;set;}
    public decimal AS40{get;set;}
    public decimal AS42{get;set;}
    public decimal AS46{get;set;}
    public decimal AS48{get;set;}
    public decimal AS50{get;set;}
    public decimal AS52{get;set;}
    public decimal AS54{get;set;}
    public decimal AS56{get;set;}
    public decimal AQ65{get;set;}
    public decimal AQ66{get;set;}
    public void someVariables(){
        try{
            AS38=(saddle.Units__c=='Standard'?BW:BW/25.4);
            AS40=(saddle.Units__c=='Standard'?BC:BC/25.4);
            AS42=(PCH==null||PCH==0?0:(saddle.Units__c=='Standard'?AO45:AO45/25.4));
            AS46=(saddle.Units__c=='Standard'?Belt_Speed:Belt_Speed/0.00508);
            AS48=(saddle.Units__c=='Standard'?Drop_Height:Drop_Height/25.4);
            AS50=(saddle.Units__c=='Standard'?MAX_Lump_Size:MAX_Lump_Size/25.4);
            AS52=(saddle.Units__c=='Standard'?Tons_per_Hour:Tons_per_Hour/0.90718474);
            AS54=Material_Density;
            AS56=(saddle.Units__c=='Standard'?MAX_Lump_Weight:MAX_Lump_Weight*2.20462262184877);
            AQ65=((BW==0||BC==0||TA_D==0||AO38==0||WH==0||CL==0||Drop_Height==0)?1:0);
            AQ66=((BC==0||BW==0||TA_D==0||AO38==0||IdlerInLoadZone=='No'||WH==0||CL==0||Drop_Height==0)?1:0);// NEED to think
        }catch(Exception ex){
            isError=true;
            //AS54=0;
        }    
    }
    public decimal SaddleSpringConstant {get;set;}
    public decimal IdlerSpringConstant {get;set;}
    public decimal FrameThickness {get;set;}
    public decimal YieldStrength {get;set;}
    public decimal RequiredFOS {get;set;}
    public decimal Volumeoflump {get;set;}
    public decimal Weightoflump {get;set;}
    public decimal WeightofAverageLinearFt {get;set;}
    public decimal Deflectionofspring_Saddle {get;set;}
    public decimal ForceSaddle {get;set;}
    public decimal DeflectionofspringIdler {get;set;}
    public decimal ForceIdler {get;set;}
    
    public decimal SaddleCenterHeightSegment {get;set;}
    public decimal SaddleFrameHeight {get;set;}
    public decimal IdlerCenterHeightRollFrame {get;set;}
    public decimal IdlerFrameHeight {get;set;}
    public decimal SaddleDropHeight {get;set;}
    public decimal IdlerDropHeight {get;set;}
    public decimal MinClearanceNeeded {get;set;}
    public decimal MaxBendingMoment{get;set;}
    public decimal ShearStress{get;set;}
    public decimal BendingStress{get;set;}
    public decimal Stress{get;set;}
    public decimal ShearFOS{get;set;}
    public decimal BendingFOS{get;set;}
    public decimal MaxBendingMoment_id{get;set;}
    public decimal ShearStress_id{get;set;}
    public decimal BendingStress_id{get;set;}
    public decimal Stress_id{get;set;}
    public decimal ShearFOS_id{get;set;}
    public decimal BendingFOS_id{get;set;}
    public string WillStandardSaddleWork{get;set;}
    public string WillStandardIdlerWork{get;set;}
    public string Willbothunitswork{get;set;}
    public void GivensStandard(){
        try{
        SaddleSpringConstant=18000;
        IdlerSpringConstant=9000;
        FrameThickness=[select id,Frame_Size__c from Specifications_Data_Base__c where Belt_Widths__c=:AS38 limit 1].Frame_Size__c;
        YieldStrength=36000;
        
        Volumeoflump=AS50*AS50*AS50;
        Weightoflump=(AS56< ((AS54/1728)*Volumeoflump)? (AS54/1728)*Volumeoflump: AS56);
        try{
            WeightofAverageLinearFt=AS52/60/AS46*2000;
        }catch(exception sdr){
            WeightofAverageLinearFt=0;
        }
        Deflectionofspring_Saddle=((Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt)/SaddleSpringConstant)+(((Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt)/SaddleSpringConstant)*Math.SQRT(1+(2*AS48/12*SaddleSpringConstant)/(Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt)));
        ForceSaddle=SaddleSpringConstant    *Deflectionofspring_Saddle; 
        DeflectionofspringIdler=((Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt)/IdlerSpringConstant)+((Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt)/IdlerSpringConstant)*Math.SQRT(1+(2*AS48/12*IdlerSpringConstant)/(Weightoflump>WeightofAverageLinearFt?Weightoflump:WeightofAverageLinearFt));
        ForceIdler=IdlerSpringConstant*DeflectionofspringIdler;
        RequiredFOS=WeightofAverageLinearFt>Weightoflump?2:2.8;
        
        SaddleCenterHeightSegment=AO45-2.75;
        SaddleFrameHeight=(SaddleCenterHeightSegment<5?5:SaddleCenterHeightSegment);
        IdlerCenterHeightRollFrame=AO45-7.4375;
        IdlerFrameHeight=IdlerCenterHeightRollFrame<5?5:IdlerCenterHeightRollFrame;
        SaddleDropHeight=SaddleFrameHeight-SaddleCenterHeightSegment;
        IdlerDropHeight=IdlerFrameHeight-IdlerCenterHeightRollFrame;
        MinClearanceNeeded=Math.max(SaddleDropHeight,IdlerDropHeight)+1;    
        
        MaxBendingMoment=(ForceSaddle*AS40)/32;
        ShearStress=ForceSaddle/(2*FrameThickness*SaddleFrameHeight*2); 
        BendingStress=12*MaxBendingMoment/(2*FrameThickness*SaddleFrameHeight*SaddleFrameHeight);
        Stress=Math.SQRT((BendingStress*BendingStress)+3*(ShearStress*ShearStress));
        ShearFOS=YieldStrength/Stress;
        BendingFOS=0.6*YieldStrength/BendingStress;
        MaxBendingMoment_id=(ForceIdler*AS40)/32;
        ShearStress_id=ForceIdler/(2*FrameThickness*IdlerFrameHeight*2);
        BendingStress_id=12*MaxBendingMoment_id/(2*FrameThickness*IdlerFrameHeight*IdlerFrameHeight);
        Stress_id=Math.SQRT((BendingStress_id*BendingStress_id)+3*(ShearStress_id*ShearStress_id));
        ShearFOS_id=Stress_id/YieldStrength;
        BendingFOS_id=0.6*YieldStrength/BendingStress_id;
        WillStandardSaddleWork=(BendingFOS>RequiredFOS?'Yes':'No');
        WillStandardIdlerWork=(BendingFOS_id>RequiredFOS?'Yes':'No');
        Willbothunitswork=((WillStandardSaddleWork=='Yes'&&WillStandardIdlerWork=='Yes')?'Yes':'No');
        }catch(Exception ex){
            isError=true;
        }
    }
    public pagereference CancelSaddle(){
        string url=saddle.id==null?'/a1O/o':'/a1O/o';//+saddle.id;
        return new pagereference(url);
    }
    public pagereference saveSaddle(){
        upsert saddle;
        System.debug(saddle.Belt_Width__c);
        isEditMode=false;
        string url=saddle.id==null?'/a1O/o':'/a1O/o';//+saddle.id;
        return null;
        //return new pagereference(url);
    }
    public pagereference editSaddle(){
        isEditMode=true;
        return null;
    }
    public pagereference joinOpp(){
        selectJoin=true;
        isnewOpp=false;
        isexisting=false;
        isoppBtns=true;
        return null;
    }
    public pagereference closejoinOpp(){
        selectJoin=false;
        isnewOpp=false;
        isexisting=false;
        isoppBtns=false;
        try{
        system.debug(saddle.Customer_Asset__c);
        system.debug(saddle.Customer_Asset__c==null);
        //system.debug(saddle.Customer_Asset__c instanceof ID);
        //system.debug(saddle.Customer_Asset__c=='');
        }catch(exception ex){
            system.debug(ex.getCause()+' '+ex.getLineNumber()+' '+ex.getMessage()+' '+ex.getStackTraceString()+' '+ex.getTypeName());
        }
        return null;
    }
    public pagereference saveOpp(){
        insert newOpp;
        saddle.opportunity__c=newOpp.id;
        /*selectJoin=false;
        isnewOpp=false;
        isexisting=false;
        isoppBtns=false;*/
        selectJoin=true;
        isnewOpp=false;
        isexisting=true;
        isoppBtns=false;
        newOpp = new opportunity();
        return null;
    }
    public pagereference existingOpp(){
        selectJoin=true;
        isnewOpp=false;
        isexisting=true;
        isoppBtns=false;
        return null;
    }
    public pagereference newOppCreate(){
        selectJoin=true;
        isnewOpp=true;
        isexisting=false;
        isoppBtns=false;
        return null;
    }
    public pagereference refresh(){
        return null;
    }
    public list<selectoption> getUpdateAssetsOptions(){
        AssetOptions = new list<selectoption>();
        AssetOptions.add(new SelectOption('',''));
        if(saddle.Opportunity__c!=null){
            set<id> assetIds = new set<id>();
            for(Opportunity_Asset__c oa:[select id,Customer_Asset__c from Opportunity_Asset__c where Opportunity__c=:saddle.Opportunity__c]){
                assetIds.add(oa.Customer_Asset__c);
            }
            for(Customer_Asset__c ca:[select id,name from Customer_Asset__c where id in:assetIds]){
                AssetOptions.add(new SelectOption(ca.id+'',ca.name+''));
            }
        }
        return AssetOptions;
    }
}