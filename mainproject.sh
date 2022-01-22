#!/bin/bash

# create databse function:
create_DB ()
            {
                        # here make a folder to put database in 
                        
                            read -p "Enter A DB Name: " name


                              if [[ -z $name  ]];
                                then 
                                        tput setaf 1
                                        echo "Empty Input"
                                        tput setaf 7
                                        create_DB

                                elif [[ $name =~ ['!@#$%^&*()_+'] ]];
                                then
                                        tput setaf 1 ;
                                        echo "incorrect input"
                                        tput setaf 7
                                        create_DB

                                
                                else 
                                        if [[ -d database/$name ]] ;
                                        then 
                                                tput setaf 1
                                                echo $tableName DB Already Exits
                                                tput setaf 7
                                                create_DB
                                        else    
                                        
                                                     mkdir database/$name
                                                 echo "congratulation DB was created "
                                                 echo "_________________"
                                                 fi
                                     fi            

                        # make new Database
               mainMenuSection             
            }


# List databases functions: 
        listDBs ()
        {
                        read -p "Enter a Database name: " name
                        if [[ -d $name ]]; then
                                ls $name;
                        else
                                echo "No database exist"
                        fi
        echo "_______________________________________________________________________________"
        echo "Select again:"
        mainMenuSection
        }


# Drop database function:
        dropDB ()
        {
                        # check the folder exist or not
                        read -p "Enter A DropDB Name: " name
                        if [[ -d database/$name ]]; then
                                echo "The DB Exists ";
                                echo "Are you Sure You Want To drop $name Database? y/n"
                                read choice;
                                        case $choice in
                                        [Yy]* ) rm -r database/$name
                                              
                                        #  done 
                                                echo "$name has been deleted"  ;;
                                        # canceled
                                        [Nn]* ) echo "Operation Canceled"  ;;
                                        # wrong input
                                                * ) echo "Invalid Input"       ;;
                                        esac
                        else
                                echo "$name doesn't exist"
                        fi 
                        
        echo "______________________________________________________________________________"            
        echo "_______________________________________________________________________________"
        echo "Select again:"
        }



# Connect to database function:
        ConnectDB()
        {
                read -p "Enter DB name: " name
                        if [[ -d database/$name ]];then
                                echo "DB exist"
                                cd database/$name
                        else
                                echo "Please make a Database first!"
                                exit;
                        fi

        tableMenuSection     # call table menu function:
        }


# main menu of DBMS
mainMenuSection()
        {

        echo "WELCOME TO OUR BDMS"
        echo "____________________________________________________________________________________"

        echo "Select from the following MENU:"

        select choice in "create_database" "list_databases" "connect_to_DB" "drop_database"  "exit"
        do
                case $choice in

                        create_database )      create_DB    ;;

                        list_databases )        listDBs     ;;

                        connect_to_DB      )       ConnectDB    ;;

                        drop_database )        dropDB       ;;

                        exit          )         exit        ;;


                        *) echo $REPLY is not one of the choices. ;;
                esac
        done
        }

# ===================================================================================================================================
# ===================================================================================================================================
# ===================================================================================================================================
# ===================================================================================================================================

#Create table function
Create_Table()
{
            
        echo    "--------------------------Create Table----------------------------------"
        echo    "________________________________________________________________________"


        read -p  "Enter Table Name: " tableName
            
        if [[ -z $tableName  ]];
        then 
                tput setaf 1  #color
                echo "Empty Input"
                Create_Table

        #check validation
        elif [[ $tableName =~ ['!@#$%^&*()_+'] ]];
        then
                tput setaf 1  #color
                echo "wrong input"
                tput setaf 7  #color
                
                Create_Table

        else 
	        if [[ -f $tableName ]] ;
	        then 
		        tput setaf 1  #color
		        echo $tableName Table Already Exits
		        Create_Table
	        else    
                #Start of Coloumn number Validation
                        while true
		        do
		                tput setaf 7  #color
		                read -p "Enter Number of Columns: " NumberCol
		 
                                # less than 0 or empty
                                        if [[ $NumberCol =~ [^1-9] ]]; 
                                        then
                                                tput setaf 1
                                                echo " input shoud be started from number 1"
                                                tput setaf 7

                                        elif [[ -z $NumberCol ]] ;
                                        then   
                                                tput setaf 1
                                                echo "Empty Input"
                                                tput setaf 7
                                        else
                                                break 
                                        fi
                        done
                #End of Coloumn number Validation

		        tput setaf 3  #color
		        echo "First Column Must Be PRIMARY KEY !!"
		        tput setaf 7  #color

                #Start of Coloumn name Validation
                        for (( i = 1 ; i <= NumberCol ; i++ ));
                        do      
                                while true
                                do
                                        read -p "Write Column Name $i : " ColName
                                        
                                        
                                        if [[ $ColName =~ ['!@#$%^&*()_+'] ]]; then
                                                tput setaf 1  #color
                                                echo "incorrect input"
                                                tput setaf 7  #color

                                        elif [[ -z $ColName ]] ;
                                        then
                                                tput setaf 1  #color
                                                echo "Empty Column Name"
                                                tput setaf 7
                        
                                        else 
                                                break ;
                                        fi
                                done 

                                tput setaf 7  #color
                                read -p "Enter DataType of $ColName column[string/int] :" ColDataType

                                while [[ $ColDataType != int && $ColDataType != string ]];
                                do      tput setaf 1  #color
                                        echo "Wrong DataType, Enter Int Or String"echo
                                
                                        read ColDataType
                                done

                                tput setaf 7  #color
                                touch $tableName
                                touch $tableName.type

                                if [[ i -eq NumberCol ]] ; then
                                        echo 	$ColName >> $tableName
                                        echo    $ColDataType>> $tableName.type
                                else
                                        echo -n $ColName":" >> $tableName
                                        echo -n $ColDataType":" >> $tableName.type
                                fi
                                
                        done
                #End of Coloumn number Validation

                        echo "-----------------------Table has been created---------------------------"
                        echo "________________________________________________________________________"
                        tput setaf 7   #color
	        fi
        fi
tableMenuSection
}



#list_tables function
list_tables()
{
        # First, check and connect to database :
        read -p "Enter DB Name: " dbName
                if [[ $dbName ]]; then
                        echo "All Tables"
                        ls ;
                        echo "_____________________________________________________________________________________"
                else
                        echo "you don't have DB "
                        exit;
                fi
}

#Insert table function
Insert() 
{
        echo  "--------------------------Insert Into Table-----------------------------"           
        echo  "________________________________________________________________________"

        read -p "Enter Table Name You Wanna insert Into: "  tbName
                if [[ -f $tbName ]]; then
 	                typeset -i cntColumns=`awk -F: '{print NF}' $tbName | head -1` ; #get number of columns in table
	                tput setaf 3  #color
                        echo "PRIMARY KEY MUST BE UNIQUE" 
                                for (( i=1 ; i <= $cntColumns ; i++ ));
                                do
                                        colname=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName | head -1` ; #first line
                                        coltype=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName.type | head -1` ; 
                                        if [[ $i -eq 1 ]] ;
                                        then
                                        #start of first coloumn loop
                                                check=0
                                                while [[ $check -eq 0 ]] ;
                                                do
                                                        tput setaf 7
                                                        read -p "Enter Value for $colname Column: " value 

                                                         if ! [[ $value =~ [`cut -d':' -f1 $tbName | grep -x $value`] ]]; then
                                                          if [[ $coltype = "int" && "$value" = +([0-9]) || $coltype = "string" && "$value" = +([a-zA-Z]) ]];
                                                        then		
                                                                echo -n  $value":" >> $tbName;
                                                        fi
                                                        check=1
                                                fi	
                                                done  
                                        #End of loop                               
                                        fi

                                        #Start loop from Second Coloumn
                                        flag=0
                                        while [[ $flag -eq 0 && $i -gt 1 ]];
                                        do
                                                tput setaf 7
                                                echo "Enter Value for $colname Column: "
                                                read value
                                                if [[ $coltype = "int" && "$value" = +([0-9]) || $coltype = "string" && "$value" = +([a-zA-Z]) ]]; then
                                                                if [[ $i == $cntColumns ]]; then
                                                                        echo $value >> $tbName;
                                                                else
                                                                        echo -n  $value":" >> $tbName;
                                                                fi
                                                        flag=1;
                                                fi
                                        done
                                        #end of loop
                                done
                else	        
	        tput setaf 7  #color
		echo  "------------------------------------------------------------------------"
		echo "Sorry $tbName Doesn't Exist";
		echo "__________________________________________________________________"
		tput setaf 7  #color
                fi  
tableMenuSection
}


#Select table func.
select_from_table(){


        echo  "--------------------------Select From Table-----------------------------"           
        echo  "________________________________________________________________________"

        read -p "Enter Name of table that you need to select it : "  tbName
        
        if [[ -f $tbName ]] ; then
        tput setaf 7
        echo "Please , Select one of these Options"
                select choice in "Select AllRecords" "Select Record"  "Select Column" "back_to_tablemenu"  
                do
                        case $choice in
                                "Select AllRecords" )
                                        echo "------------------------Select All Records------------------------------"
                                        echo "____________________________________________________________________"
                                        column -t -s ':' $tbName.type
                                        column -t -s ':' $tbName
                                
                                        echo "______________________________________________________"
                                        ;;


                                "Select Record" )
                                        read -p "Enter your pk: " value

                                        if [[ -z $value ]] ; then
                                                tput setaf 1
                                                echo "Empty Input"
                                                tput setaf 7
                                                select_function
                                        else
                                                echo "------------------------------------------------------------"

                                                column -t -s ':' $tbName.type 
                                                awk -F':' "/$value/" $tbName | cat
                                                echo "_____________________________________"
                                                tput setaf 7
                                        fi 
                                        ;;
                                
                                "Select Column" )
                                        read -p "Enter Column Number you wanna select" value 

                                        while ! [[ $value =~ ^[1-9]+$ ]]
                                        do
                                                tput setaf 1
                                                read -p "Column Number Must be Integer" value 
                                                tput setaf 7

                                        done

                                                cut -d':' -f$value $tbName.type
                                                cut -d':' -f$value $tbName
                                                echo "____________________________________________________________________________________"
                                        ;;

                                "back_to_tablemenu" )
                                        tableMenuSection

                                        ;;

                                
                                *)     
                                        tput setaf 1 
                                        echo "Please, Enter valid Number"
                                        tput setaf 7

                                        ;;
                        esac
                done
        select_from_table
        else
        echo $tbName Table Doesnt Exits ;
        echo "________________________________________________________________________________"
        fi

}



#delete from table func.      
Delete_Record() 
{
       echo  "----------------------------Delete Record-------------------------------"           
    echo  "________"

    read -p "Please, Enter Table Name you wanna Delete from:" tbName
            
    if [[ -f $tbName ]] ; then

        colname=`awk -F ":" '{if(NR==1) print $1}' $tbName`;

        read -p "Enter Value for $colname Column: " recDel 
                             
        if [[ -z $recDel ]] ; then
            tput setaf 1
            echo "Empty Input"
            Delete_Record
               
        elif [[ $recDel ]]; then
             echo  $tbName "Befero Delete"
             echo  "_________________________"
             column -t -s '|'   $tbName.type
             column -t -s '|'   $tbName
             echo "___________________________"

            

            if [[ $recDel =~ [`cut -d':' -f1 $tbName | grep -x $recDel`] ]]; then
            
             rec_no=`awk 'BEGIN{FS=":"}{if ($1=="'$recDel'") print NR}' $tbName`

                sed -i ''$rec_no'd'  $tbName   
                echo "Record deleted successfuly"

		        #  if  grep -q "$recDel" "$tbName";then          
            else              
                echo "there is no pk with this number"
            fi


             echo "_________________________"

             echo  $tbName "After Delete"
             echo  "________________________"
             column -t -s '|'   $tbName.type
             column -t -s ':'   $tbName
             echo  "_________________________"
        else
            echo "this PK not exist"
            Delete_Record
        fi 
    else 
        echo Sorry $tbName Table Doesnt Exits ;
        echo "------------------------------------------------------------------------"       
    fi
}


droptable ()
{
                        # check the folder exist or not
                        read -p "Enter a table name: " tbName
                        if [[ -f $tbName ]]; then
                                echo "The DB Exists ";
                                echo "Are you Sure You Want To drop $tbName Database? y/n"
                                read choice;
                                        case $choice in
                                        [Yy]* ) rm -r $tbName 
                                                rm -r $tbName.type
                                        #  done 
                                                echo "$tbName has been deleted"  ;;
                                        # canceled
                                        [Nn]* ) echo "Operation Canceled"  ;;
                                        # wrong input
                                                * ) echo "Invalid Input"       ;;
                                        esac
                        else
                                echo "$tbName doesn't exist"
                        fi 
                        
        echo "______________________________________________________________________________"            
        echo "_______________________________________________________________________________"
        echo "Select again:"
}

#Table Menu function
tableMenuSection()
{

        echo "______________________________________________________________________________________"

        echo "Select from the following MENU:"

        select choice in "create_table" "list_tables" "drop_table" "insert_to_table" "select_table" "delete_from_table" 
        do
                case $choice in 
                        
                        create_table       ) Create_Table  ;;
                        list_tables        ) list_tables   ;;
                        drop_table         ) droptable     ;;
                        insert_to_table    ) Insert        ;;
                        select_table       ) select_from_table ;;
                        delete_from_table  ) Delete_Record ;;
                
                esac
        done

        mainMenuSection  #call back main menu func.
                
 }         
            
#Run the Program Function:
        mkdir database 2>>.err.log
        mainMenuSection

           