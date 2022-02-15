proc highlighting { colorId representation id selection } {
   puts "highlighting $id"
   mol representation $representation
   mol material "Diffuse" 
   mol color $colorId
   mol selection $selection
   mol addrep $id
}

set pdb [lindex $argv 0]
set pocket1Len [lindex $argv 1]
set pocket2Len [lindex $argv 2]
set pocket3Len [lindex $argv 3]

set pocket1End [expr [expr $pocket1Len]+3]
set pocket2End [expr $pocket1End+[expr $pocket2Len]]
set pocket3End [expr $pocket2End+[expr $pocket3Len]]

set pocket1 [lrange $argv 4 $pocket1End]
set pocket2 [lrange $argv $pocket1End+1 $pocket2End]
set pocket3 [lrange $argv $pocket2End+1 $pocket3End]

set id [mol new $pdb.pdb type pdb]
highlighting Element "NewCartoon" $id "protein"
highlighting "ColorID 1" "QuickSurf 0.6" $id $pocket1
highlighting "ColorID 3" "QuickSurf 0.6" $id $pocket2
highlighting "ColorID 4" "QuickSurf 0.6" $id $pocket3
render TachyonInternal $pdb.tga
exit
