sudo apt-get update
sudo apt-get install -y apache2 php7.0 libapache2-mod-php7.0
sudo apt-get -y install mysql-server
sudo apt-get -y install php7.0-mysql
sudo service apache2 restart
echo What title would you like to have on your site ?
read title
echo What will be your admin username ?
read admin_user
echo What will be your admin password ?
read admin_password
echo What is your adress email ?
read mail_adress
echo Voulez-vous installer WordPress ? \"oui\" pour le faire
read reponseWordPress
if [ "$reponseWordPress" = "oui" ];
then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	sudo mv wp-cli.phar /usr/local/bin/wp
	wp core download --locale=fr_FR
	wp config create --dbname=wordpress --dbuser=$admin_user --dbpass=$admin_password
else
        echo Vous avez choisis de ne pas réinstaller WordPress
fi
wp core is-installed
	if [ $? = 1 ]
	then
		wp core install --url=192.168.33.10 --title=$title --admin_user=$admin_user --admin_password=$admin_password --admin_email=$mail_adress
		echo Everything went good, enter "check" to check your wordpress status, press another key to skip this
		read checkStatus
		if [ "$checkStatus" = "check" ];
		then
			wp --info
		research="base"
		select=""
		i="0"
		j="0"
		while [ "$select" != "q" ] || [ "$i" = "0" ]
		do
			$j = 0
			echo Voulez vous gérer vos plugins ou vos thèmes ? entrez \"plugins\", \"themes\" ou \"q\" pour quitter le programme
			read select
			if [ "$select" = "plugins" ];
			then
				while [ $prompt != "q" || $j = 0 ]
				do
					echo Vous pouvez chercher, installer, supprimer, activer ou désactiver un plugin a l\'aide des commandes \"search\", \"install\", \"activate\", \"deactivate\", ou quitter avec \"q\"
					echo Que voulez-vous faire ?
					read prompt
					if  [ "$prompt" = "search" ]
					then
						echo Quel est le plugin que vous voulez chercher ?
						read research
						wp plugin search $research
					elif [ "$prompt" = "install" ];
					then
						echo Le plug in que vous voulez installer est bien le plugin-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
						read resultTestResearch
						if [ "$resultTestResearch" = "oui" ];
						then
							wp plugin is-installed $resarch
                                        	        if [ $? = 1 ]
                                        	        then
                                        	                echo Ce plugin est déja installé
                                        	        else
                                        	                wp plugin install $research
                                               		fi
						elif [ "$resultTestResearch" = "non" ];
						then
                                                        echo Quel est le plugin que vous voulez installer ?
							read newResearch
							wp plugin is-installed $newResearch
							if [ $? = 1 ]
							then
								echo Ce plugin est déja installer. 
							else
								wp plugin install $newResearch
							fi
						else
							echo veuillez entrer une commande valide
						fi
					elif [ "$prompt" = "uninstall" ];
					then
						echo Le plug in que vous voulez désinstaller est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp plugin is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un plugin qui n\'est pas installé.
                                                        else
                                                                wp plugin delete $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
							echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un plugin qui n\'est pas installé
                                                        else
                                                                wp plugin delete $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					elif [ "$prompt" = "activate" ];
					then
						echo Le plug in que vous voulez activer est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
						then
							wp plugin is-installed $research
                                                        if [ $? = 1 ]
                                                        then
                                                                wp plugin activate $research
                                                        else
                                                                echo Ce plugin n\'est pas installé, veuillez l\'installer
                                                        fi
						elif [ "$resultTestResearch" = "non" ];
                                                then
							echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp plugin activate $newResearch
                                                        else
                                                                echo Ce plugin n\'est pas installé, veuillez l\'installer
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					elif [ "$prompt" = "deactivate" ];
					then
						echo Le plug in que vous voulez activer est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
						read resultTestResearch
						if [ "$resultTestResearch" = "oui" ];
						then
							wp  plugin is-installed $research
							if [ $? = 1 ]
							then
								wp plugin deactivate $research
							else
								echo echo Ce plugin n\'est pas installé
							fi
						elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp plugin deactivate $newResearch
                                                        else
                                                                echo Ce plugin n\'est pas installé
                                                        fi
						fi
                                        elif [ "$prompt" = "q" ];
                                        then
                                                break
					fi
					let j++
				done
			elif [ "$select" = "themes" ];
			then
				while [ "$prompt" != "q" ] || [] "$j" = "0" ]
                                do
                                        echo Vous pouvez chercher, installer, supprimer ou activer  un thème a l\'aide des commandes \"search\", \"install\", \"uninstall\ et \"activate\" ou quitter avec \"q\"
                                        echo Que voulez-vous faire ?
                                        read prompt
                                        if  [ "$prompt" = "search" ];
                                        then
                                                echo Quel est le thème que vous voulez chercher ?
                                                read research
                                                wp theme search $research
                                        elif [ "$prompt" = "install" ];
                                        then
                                                echo Le thème que vous voulez installer est bien le plugin-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Ce thème est déja installé
                                                        else
                                                                wp theme install $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le thème que vous voulez installer ?
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Ce thème est déja installer.
                                                        else
                                                                wp theme install $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					 elif [ "$prompt" = "uninstall" ];
					 then
                                                echo Le thème que vous voulez désinstaller est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un thème qui n\'est pas installé.
                                                        else
                                                                wp theme delete $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du theme ?
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un theme qui n\'est pas installé
                                                        else
                                                                wp theme delete $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
                                        elif [ "$prompt" = "activate" ];
                                        then
                                                echo Le theme que vous voulez activer est bien le theme que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $research
                                                        if [ $? = 1 ]
                                                        then
                                                                wp theme activate $research
                                                        else
                                                                echo Ce theme n\'est pas installé, veuillez l\'installer
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du theme ?
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp theme activate $newResearch
                                                        else
                                                                echo Ce theme n\'est pas installé, veuillez l\'installer
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
                                        elif [ "$prompt" = "q" ];
                                        then
                                                break
					fi
					let j++
				done		
			elif [ "$select" = "q" ];
			then
				echo A bientot, si tu veux à nouveau gérer tes programmes, n\'hésite pas à relancer le programme !
				break;
			fi
			let i++
		done	
	fi
        else
	        echo WordPress is already installed, the installation will not be done.
                research="base"
		select=""
		i="0"
		j="0"
		while [ "$select" != "q" ] || [ "$i" = "0" ]
		do
			j="0"
			echo Voulez vous gérer vos plugins ou vos thèmes ? entrez \"plugins\", \"themes\" ou \"q\" pour quitter le programme
			read select
			if [ "$select" = "plugins" ];
			then
				while [ "$prompt" != "q" ] || [ "$j" = "0" ]
				do
					echo Vous pouvez chercher, installer, supprimer, activer ou désactiver un plugin a l\'aide des commandes \"search\", \"install\", \"activate\", \"deactivate\", ou quitter avec \"q\"
					echo Que voulez-vous faire ?
					read prompt
					if  [ "$prompt" = "search" ]
					then
						echo Quel est le plugin que vous voulez chercher ?
						read research
						wp plugin search $research
					elif [ "$prompt" = "install" ];
					then
						echo Le plug in que vous voulez installer est bien le plugin-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
						read resultTestResearch
						if [ "$resultTestResearch" = "oui" ];
						then
							wp plugin is-installed $resarch
                                        	        if [ $? = 1 ]
                                        	        then
                                        	                echo Ce plugin est déja installé
                                        	        else
                                        	                wp plugin install $research
                                               		fi
						elif [ "$resultTestResearch" = "non" ];
						then
                                                        echo Quel est le plugin que vous voulez installer ?
							read newResearch
							wp plugin is-installed $newResearch
							if [ $? = 1 ]
							then
								echo Ce plugin est déja installer. 
							else
								wp plugin install $newResearch
							fi
						else
							echo veuillez entrer une commande valide
						fi
					elif [ "$prompt" = "uninstall" ];
					then
						echo Le plug in que vous voulez désinstaller est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp plugin is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un plugin qui n\'est pas installé.
                                                        else
                                                                wp plugin delete $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
							echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un plugin qui n\'est pas installé
                                                        else
                                                                wp plugin delete $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					elif [ "$prompt" = "activate" ];
					then
						echo Le plug in que vous voulez activer est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
						then
							wp plugin is-installed $research
                                                        if [ $? = 1 ]
                                                        then
                                                                wp plugin activate $research
                                                        else
                                                                echo Ce plugin n\'est pas installé, veuillez l\'installer
                                                        fi
						elif [ "$resultTestResearch" = "non" ];
                                                then
							echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp plugin activate $newResearch
                                                        else
                                                                echo Ce plugin n\'est pas installé, veuillez l\'installer
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					elif [ "$prompt" = "deactivate" ];
					then
						echo Le plug in que vous voulez activer est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
						read resultTestResearch
						if [ "$resultTestResearch" = "oui" ];
						then
							wp  plugin is-installed $research
							if [ $? = 1 ]
							then
								wp plugin deactivate $research
							else
								echo echo Ce plugin n\'est pas installé
							fi
						elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du plugin ?
                                                        read newResearch
                                                        wp plugin is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp plugin deactivate $newResearch
                                                        else
                                                                echo Ce plugin n\'est pas installé
                                                        fi
						fi
                                        elif [ "$prompt" = "q" ];
                                        then
                                                break
					fi
					let j++
				done
			elif [ "$select" = "themes" ];
			then
				while [ "$prompt" != "q" ] || [ "$j" = "0" ]
                                do
                                        echo Vous pouvez chercher, installer, supprimer ou activer  un thème a l\'aide des commandes \"search\", \"install\", \"uninstall\ et \"activate\" ou quitter avec \"q\"
                                        echo Que voulez-vous faire ?
                                        read prompt
                                        if  [ "$prompt" = "search" ];
                                        then
                                                echo Quel est le thème que vous voulez chercher ?
                                                read research
                                                wp theme search $research
                                        elif [ "$prompt" = "install" ];
                                        then
                                                echo Le thème que vous voulez installer est bien le plugin-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Ce thème est déja installé
                                                        else
                                                                wp theme install $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Entrer le thème que vous voulez installer
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Ce thème est déja installer.
                                                        else
                                                                wp theme install $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
					 elif [ "$prompt" = "uninstall" ];
					 then
                                                echo Le thème que vous voulez désinstaller est bien le plug-in que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $resarch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un thème qui n\'est pas installé.
                                                        else
                                                                wp theme delete $research
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du theme ?
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                echo Vous ne pouvez pas supprimer un theme qui n\'est pas installé
                                                        else
                                                                wp theme delete $newResearch
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
                                        elif [ "$prompt" = "activate" ];
                                        then
                                                echo Le theme que vous voulez activer est bien le theme que vous avez recherché : $research ? Entrez \"oui\" ou \"non\"
                                                read resultTestResearch
                                                if [ "$resultTestResearch" = "oui" ];
                                                then
                                                        wp theme is-installed $research
                                                        if [ $? = 1 ]
                                                        then
                                                                wp theme activate $research
                                                        else
                                                                echo Ce theme n\'est pas installé, veuillez l\'installer
                                                        fi
                                                elif [ "$resultTestResearch" = "non" ];
                                                then
                                                        echo Quel est le nom du theme ?
                                                        read newResearch
                                                        wp theme is-installed $newResearch
                                                        if [ $? = 1 ]
                                                        then
                                                                 wp theme activate $newResearch
                                                        else
                                                                echo Ce theme n\'est pas installé, veuillez l\'installer
                                                        fi
                                                else
                                                        echo veuillez entrer une commande valide
                                                fi
						
                                        elif [ "$prompt" = "q" ];
                                        then
                                                break
					fi
                                        let j++
				done		
			elif [ "$select" = "q" ];
			then
				echo A bientot, si tu veux à nouveau gérer tes programmes, n\'hésite pas à relancer le fichier! 
				break;
			fi
			let i++
		done	
	fi