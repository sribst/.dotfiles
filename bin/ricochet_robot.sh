#!/bin/bash

#creer le jeu et place les pieces
#et stocke le jeu initial dans playboardrestart
#la sortie s'appelle playboard matrice 33 x 33
declare -A playboard
declare -A playboardrestart

num_rows=33
num_columns=33
#creer le jeu et place aléatoirement les robots
function create_playboard {

for r in "R" "B" "G" "Y"
	do
		eval "$r=$(($RANDOM%196+1))"
	done
#let "a=$RANDOM%196+1"
#echo $a
var=0
var4=0
var5=0
for ((i=1;i<=num_rows;i++)) do
    var2=0
    for ((j=1;j<=num_columns;j++)) do
#mur sur le pourtour
      if [[ $i -eq 1 || $i -eq 33 || $j -eq 1 || $j -eq 33 ]];then
        playboard[$i,$j]="M"
      elif [[ $i%2 -eq 0 && $j%2 -eq 0 ]];then
	    ((var++))
		if [[ $i == 16 || $i == 18 ]] && [[ $j == 16 || $j == 18 ]];then
		   playboard[$i,$j]="M"
		elif [ $var -eq $R ];then
		   playboard[$i,$j]="R"
		elif [ $var -eq $B ];then
		   playboard[$i,$j]="B"
		elif [ $var -eq $G ];then
		   playboard[$i,$j]="G"
		elif [ $var -eq $Y ];then
		   playboard[$i,$j]="Y"		    
		else
			playboard[$i,$j]="A"
		fi
#mur haut et bas
      elif [[ $i -eq 2 || $i -eq 32 ]] ;then
	        ((var2++))
	        if [[ $j -eq 3 ]] ;then
			    let "a=$RANDOM%12+2"
			    let "b=$RANDOM%12+2"
				let " c = a - b"
				
				if [[ $a -eq $b  && $a -le 10 ]] ;then
				      let " b = a + 4"
				fi
				if [[ $a -eq $b  && $a -ge 10 ]] ;then
                      let " b = a - 5"
				fi
				if [[ $c -gt 0 && $c -lt 3 && $a -le 11 ]] ; then
				      let " a = a + 3" 
				fi
				
				if [[ $c -gt 0 && $c -lt 3 && $a -ge 11 ]] ; then
				      let  " b = b - 2"
				fi
				
				if [[ $c -lt 0 && $c -gt -3 && $b -le 11 ]] ; then
				      let "b = b + 3"
				fi
				if [[ $c -lt 0 && $c -gt -3 && $b -ge 11 ]] ; then
				      let "a = a - 3"
				fi
				
				playboard[$i,$j]="A"				
			elif [[ $var2 -eq $a || $var2 -eq $b ]] ;then
				playboard[$i,$j]="M"
			else
				playboard[$i,$j]="A"
			fi   
#mur gauche			
	   elif [[ $j -eq 2 ]] ;then
	        ((var4++))
	        if [[ $i -eq 3 ]] ;then
			    let "g1=$RANDOM%12+2"
			    let "g2=$RANDOM%12+2"
				let " g3 = g1 - g2"
				if [[ $g1 -eq $g2  && $g1 -le 10 ]] ;then
				      let " g2 = g1 + 4"
				fi
				if [[ $g1 -eq $g2 && $g1 -ge 10 ]] ;then
                      let " g2 = g1 - 5"
				fi
				if [[ $g3 -gt 0 && $g3 -lt 3 && $g1 -le 11 ]] ; then
				      let " g1 = g1 + 3" 
				fi
				
				if [[ $g3 -gt 0 && $g3 -lt 3 && $g1 -ge 11 ]] ; then
				      let  " g2 = g2 - 2"
				fi
				
				if [[ $g3 -lt 0 && $g3 -gt -3 && $g2 -le 11 ]] ; then
				      let "g2 = g2 + 3"
				fi
				if [[ $g3 -lt 0 && $g3 -gt -3 && $g2 -ge 11 ]] ; then
				      let "g1 = g1 - 3"
				fi
				playboard[$i,$j]="A"				
			elif [[ $var4 -eq $g1 || $var4 -eq $g2 ]] ;then
				playboard[$i,$j]="M"
			else
				playboard[$i,$j]="A"
			fi
#mur droit			
      elif [[ $j -eq 32 ]] ;then
	        ((var5++))
	        if [[ $i -eq 3 ]] ;then
			    let "d1=$RANDOM%12+2"
			    let "d2=$RANDOM%12+2"
				let " d3 = d1 - d2"
				if [[ $d1 -eq $d2  && $d1 -le 10 ]] ;then
				      let " d2 = d1 + 4"
				fi
				if [[ $d1 -eq $d2  && $d1 -ge 10 ]] ;then
                      let " d2 = d1 - 5"
				fi
				if [[ $d3 -gt 0 && $d3 -lt 3 && $d1 -le 11 ]] ; then
				      let " d1 = d1 + 3" 
				fi
				
				if [[ $d3 -gt 0 && $d3 -lt 3 && $d1 -ge 11 ]] ; then
				      let  " d2 = d2 - 2"
				fi
				
				if [[ $d3 -lt 0 && $d3 -gt -3 && $d2 -le 11 ]] ; then
				      let "d2 = d2 + 3"
				fi
				if [[ $d3 -lt 0 && $d3 -gt -3 && $d2 -ge 11 ]] ; then
				      let "d1 = d1 - 3"
				fi
				playboard[$i,$j]="A"				
			elif [[ $var5 -eq $d1 || $var5 -eq $d2 ]] ;then
				playboard[$i,$j]="M"
			else
				playboard[$i,$j]="A"
			fi
#case centrale			
	  elif [[ $i -eq 15 || $i -eq 16 || $i -eq 17 || $i  -eq 18  ||$i -eq 19 ]] && [[ $j -eq 15 || $j -eq 16 || $j -eq 17 || $j  -eq 18  ||$j -eq 19 ]] ;then
			playboard[$i,$j]="M"


#obstacle
	  elif  (( 2 <= $i <= 32 && 2 <= $j <= 32 ));then 
	  workVar="${playboard[$i,$j]}"
		if [[ $i%2 -ne 0 && $j%2 -ne 0 ]] ; then
			let "wall = $RANDOM%50+0" # 1 on 31 chances to spawn a wall
			if [[ $wall -eq 0 ]] ; then
				playboard[$i,$j]="M"
				let "dir_wall = $RANDOM%4+0" # 1 of the 4 wall set 
				if [[ dir_wall -eq 0 ]] ; then 
					echo ":gauche bas:"
					playboard[$i,$((j-1))]="M" #gauche
					playboard[$((i+1)),$j]="M" #bas
					echo "c bien ${playboard[$((i+1)),$j]}"
					echo ":$((i+1)),$j:"

				elif [[ dir_wall -eq 1 ]] ; then
					playboard[$i,$((j-1))]="M" #gauche
					playboard[$((i-1)),$j]="M" #haut

				elif [[ dir_wall -eq 2 ]] ; then
					playboard[$i,$((j+1))]="M" #droite
					playboard[$((i-1)),$j]="M" #haut

				elif [[ dir_wall -eq 3 ]] ; then
					playboard[$i,$((j+1))]="M" #droite					
					playboard[$((i+1)),$j]="M" #bas
				fi
			else
				playboard[$i,$j]="A"
			fi
		#echo "${playboard[$i,$j]}"
		
		
		else
			#echo "c avant :$workVar:"
			if [ "$workVar" == "M" ];then
				echo "c un M :$workVar:"
				echo "else :$i,$j:"
				playboard[$i,$j]="M"
			else 
				if [ -z "$workVar" ];then
					echo "c vide :$workVar:"
					echo "else :$i,$j:"
					playboard[$i,$j]="A"
				
				fi
				if [ "$workVar" == "A" ];then
					echo "c un A :$workVar:"
					echo "else :$i,$j:"
					playboard[$i,$j]="A"
				fi		
			fi				
		fi
	  else 
	  	echo "c vide :${playboard[$i,$j]}:"
	  	playboard[$i,$j]="A"
	  fi
    done
done

f1="%$((${#num_rows}+1))s"
f2=" %3s"

printf "$f1" ''
for ((j=1;j<=num_rows;j++)) do
    printf "$f2" $j
done
echo

for ((i=1;i<=num_columns;i++)) do
    printf "$f1" $i
    for ((j=1;j<=num_rows;j++)) do
        printf "$f2" ${playboard[$i,$j]}
    done
    echo
done

for ((j=1;j<=num_rows;j++)) do
	for ((i=1;i<=num_columns;i++)) do
	eval playboardrestart[$i,$j]=${playboard[$i,$j]}
	done
done



}
#affiche le jeu (robot + playboard) en fonction de la matrice + commande
function affichage {
clear
echo -e "\033[0m************************************************************************"
echo "*                                                                      *"
echo "*           Bienvenue dans bash ricochets robots                       *"
echo "*                                                                      *"
echo "************************************************************************"
echo " "
case $1 in
  R) echo " le robot controlé est le rose (R)" ;;
  B) echo " le robot controlé est le bleu (B)" ;;
  G) echo " le robot controlé est le vert (G)" ;;
  Y) echo " le robot controlé est le jaune (Y)" ;;
esac
echo " "
echo "Les robots sont controlés par les fleches du clavier"
echo " "
echo "Taper R pour controler le rose "
echo "Taper B pour controler le bleu"
echo "Taper G pour controler le vert "
echo "Taper Y pour controler le jaune"
echo " "
echo "Taper Q pour quitter"
echo " "
echo "Taper z pour recommencer"
echo " "
echo "Taper n pour une nouvelle partie"
echo " "
echo " "
for ((i=1;i<=num_rows;i++)) 
do
    line=""
    for ((j=1;j<=num_columns;j++)) 
	 do
		if [[ $i%2 -ne 0 ]] ;then 	
			if [[ ${playboard[$i,$j]} == "M" && $j%2 -ne 0 ]] ;then
				line="$line\033[0;31;1;7m+"
			elif [[ ${playboard[$i,$j]} == "A" && $j%2 -ne 0 ]] ;then	
			     line="$line\033[0;7m+"
			elif [[ ${playboard[$i,$j]} == "M" && $j%2 -eq 0 ]] ;then
				line="$line\033[0;31;1;7m---"					  
			elif [[ ${playboard[$i,$j]} == "A" && $j%2 -eq 0 ]] ;then
				line="$line\033[0;7m---"
			else
				#echo ":${playboard[$i,$j]}:" 
				line="$line\033[0;7m---"
			fi
		else
			if [[ ${playboard[$i,$j]} == "M" && $j%2 -ne 0 ]] ;then
				line="$line\033[0;31;1;7m|"
			elif [[ ${playboard[$i,$j]} == "A" && $j%2 -ne 0 ]] ;then	
			     line="$line\033[0;7m|"
			elif [[ ${playboard[$i,$j]} == "A" && $j%2 -eq 0 ]] ;then
				line="$line\033[0;7m   "
			elif [[ ${playboard[$i,$j]} == "M" && $j%2 -eq 0 ]] ;then
				line="$line\033[0;31;7m   "				
			else
			    if [[ ${playboard[$i,$j]} == "G" ]] ;then
				    line="$line\033[0;32;1;7m-O-"
				elif [[ ${playboard[$i,$j]} == "B" ]] ;then
				    line="$line\033[0;34;1;7m-O-"
				elif [[ ${playboard[$i,$j]} == "R" ]] ;then
				    line="$line\033[0;35;1;7m-O-"
				elif [[ ${playboard[$i,$j]} == "Y" ]] ;then
				    line="$line\033[0;33;1;7m-O-"
				else
					line="$line\033[0;7m---"
				fi
			fi
		fi	 
    done
	echo -e "$line"
done
}
#deplacer le robot vers la gauche
#prend en argument le robot à déplacer
function gauche {
col=0
lin=0
for ((j=1;j<=num_columns;j++))
do
    for ((i=1;i<=num_rows;i++)) 
	 do
      if [[ ${playboard[$i,$j]} == $1 ]];then
      col=$j
	  lin=$i
	  break;
	  fi
     done
done
echo ${playboard[$lin,$col]}
playboard[$lin,$col]="A"
echo $col
echo $lin
((col--))	 
for ((j=$col;j>=1;j--)) 
   do
   if [[ ${playboard[$lin,$j]} != "A" ]] ;then
      if [[  ${playboard[$lin,$j]} == "M" ]]  ;then
	  ((j++))
	  playboard[$lin,$j]=$1
       break;	  
	  else
	  ((j++))
	  ((j++))
	  playboard[$lin,$j]=$1
	  break;
	 fi 
  fi	 
  done
}
#deplacer le robot vers la droite
#prend en argument le robot à déplacer
function droite {
col=0
lin=0
for ((j=1;j<=num_columns;j++))
do
    for ((i=1;i<=num_rows;i++)) 
	 do
      if [[ ${playboard[$i,$j]} == $1 ]];then
      col=$j
	  lin=$i
	  break;
	  fi
     done
done
echo ${playboard[$lin,$col]}
playboard[$lin,$col]="A"
echo $col
echo $lin
((col++))	 
for ((j=$col;j<=num_columns;j++)) 
   do
   if [[ ${playboard[$lin,$j]} != "A" ]] ;then
      if [[  ${playboard[$lin,$j]} == "M" ]]  ;then
	  ((j--))
	  playboard[$lin,$j]=$1
       break;	  
	  else
	  ((j--))
	  ((j--))
	  playboard[$lin,$j]=$1
	  break;
	 fi 
  fi	 
  done
}
#deplacer le robot vers le haut
#prend en argument le robot à déplacer
function haut {
col=0
lin=0
for ((j=1;j<=num_columns;j++))
do
    for ((i=1;i<=num_rows;i++)) 
	 do
      if [[ ${playboard[$i,$j]} == $1 ]];then
      col=$j
	  lin=$i
	  break;
	  fi
     done
done
echo ${playboard[$lin,$col]}
playboard[$lin,$col]="A"
echo $col
echo $lin
((lin--))	 
for ((i=$lin;i>=1;i--)) 
   do
   if [[ ${playboard[$i,$col]} != "A" ]] ;then
      if [[  ${playboard[$i,$col]} == "M" ]]  ;then
	  ((i++))
	  playboard[$i,$col]=$1
       break;	  
	  else
	  ((i++))
	  ((i++))
	  playboard[$i,$col]=$1
	  break;
	 fi 
  fi	 
  done
}
#deplacer le robot vers le bas
#prend en argument le robot à déplacer
function bas {
col=0
lin=0
for ((j=1;j<=num_columns;j++))
do
    for ((i=1;i<=num_rows;i++)) 
	 do
      if [[ ${playboard[$i,$j]} == $1 ]];then
      col=$j
	  lin=$i
	  break;
	  fi
     done
done
echo ${playboard[$lin,$col]}
playboard[$lin,$col]="A"
echo $col
echo $lin
((lin++))	 
for ((i=$lin;i<=num_rows;i++)) 
   do
   if [[ ${playboard[$i,$col]} != "A" ]] ;then
      if [[  ${playboard[$i,$col]} == "M" ]]  ;then
	  ((i--))
	  playboard[$i,$col]=$1
       break;	  
	  else
	  ((i--))
	  ((i--))
	  playboard[$i,$col]=$1
	  break;
	 fi 
  fi	 
  done
}
#quitte et genere le message de sortie
function aurevoir {
echo -e "\033[0m"
echo -e ""
echo -e " bye bye i hope you have enjoyed richochet robot "
echo -e ""
echo -e ""
clear
exit
}
#restart au début
function restart {
for ((j=1;j<=num_rows;j++)) do
	for ((i=1;i<=num_columns;i++)) do
	eval playboard[$i,$j]=${playboardrestart[$i,$j]}
	done
done
affichage
move "R"
}
#demarrer une nouvelle partie
function newgame {
create_playboard
affichage "R"
move "R"
}
#deplacer un robot avec les fleches
#prend en argument le robot à déplacer
function move {

while read -rsn1 k # Read one key (first byte in key press)
do
    case "$k" in
	      q)aurevoir;;
		  r)affichage "R"
			move "R" ;;
	      b)affichage "B"
			 move "B";;
		  g)affichage "G"
		    move "G";;
	      y)affichage "Y"
		  move "Y" ;;
		  z)restart ;;
		  n)newgame ;;
    $'\x1b') # ESC
        read -rsn1 k
        [ "$k" == "" ] && return    # Esc-Key
        [ "$k" == "[" ] && read -rsn1 k
        [ "$k" == "O" ] && read -rsn1 k
        case "$k" in
        A) # Up
           haut $1
		   affichage $1 ;;
        B) # Down
           bas $1 
		   affichage $1 ;;
        C) #right
		   droite $1
           affichage $1 ;;		
		D) #left
		  gauche $1 
		  affichage $1 ;;
       esac
   esac
done
}
create_playboard
affichage "R"
move "R"




