# My Plans for this OS
Because LMNet is a good Bash OS, I want an grapical os. I create the startup file and I plan to create a Launcher like the Ubuntus Unity.
I know that this isn't my os so if you don't like my Ideas you can write it here so I delete the files. 
I will use /Programs/<Name> to store Programs there, like OneOS. 

I also will create functions and tools so that you don't need much code for simple data. Like my AppData.load(). 
I also want to integrate much APIs of LMNet, because I domt want wo write them again. I will pull it from the LMNet Repo, so I hope it's ok!

I hope that my Code isn't a problem. 
~timia2109

## System Informations:

### Program Folder (just startup is required)
```
Files inside:
 - startup (the Code) (Required) <code>
 - data (using the AppData function) <serialized table>
 - icon (yeah you know) <paint format>
 - program (Table with Informations) <serialized table>
   - Description
   - alias
   - Update URL / Repo
   - Author
   - Version / Commit (For auto-update)
   
< Add your Ideas here>
```

### System Pathes:
```
 - /Programs (Apps inside)
 - /Programs/[AppName] (AppFolder)
 - /FrostOS (System Folder)
 - /FrostOS/apis (Auto-loaded APIS)
 - /FrostOS/system (App Folder for System Programms Run with run("sys/..."))
 - /FrostOS/resources (additional scripts)
```

### New APIs:
```
 - run() (Can use the program name, the script Path, sys/... for an system program or app: like Android so that you can choose other apps for that action for example the Launcher)
 - table.serach(pTable,pResult) (Return the index of the element or nil)
 - is_table, is_string, is_number, is_table, is_program, is_systemProgram (Returns true or false, Much less code)
 - Add content here
 ```
 
---
Well,
I see where your going with this!
We have a bash OS (LMNet) and we might aswell have a go at making a graphical one.
**~Lewis**
