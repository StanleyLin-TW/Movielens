#include <iostream>
#include <string.h>
#include <string>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netdb.h>
#include <cstring>
#include <stdlib.h>
#include <unistd.h>
using namespace std;

#define local_buffer 1024

int main(int argc, char *argv[]){ //input 執行
	if (argc<3){
		cout<< endl <<"Wrong Input."<<endl;
		return 0;
	}
	int socketfd;
	struct addrinfo hints, *res;
	char recv_buf[local_buffer];

	memset(&hints, 0, sizeof hints);
	hints.ai_family= AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	getaddrinfo(argv[1],argv[2], &hints, &res); // get the server profile (IP, port)
	if((socketfd=socket(res -> ai_family, res-> ai_socktype, res->ai_protocol))==-1){
	}
	if ((connect(socketfd,res->ai_addr,res->ai_addrlen))==-1){
			close(socketfd);
	} 

	struct sockaddr_in sin;
	socklen_t len = sizeof(sin);
	if (getsockname(socketfd, (struct sockaddr *)&sin, &len) == -1){

	}
	else{
		printf("port number %d\n", ntohs(sin.sin_port));
	}

	recv(socketfd, recv_buf, local_buffer, 0);
	cout << recv_buf;
	cout << endl<<"Enter 1 for register, 2 for login:";
	//register
	string choice;
	cin >> choice;
	string name;
	string balance;
	int port;
	bool login_suc=false;
	while(!login_suc){
		if(choice == "1") {//REGISTER
			cout << "Enter the name u want to register:";
			cin >> name;
			cout << "Enter the initial balance:";
			cin >> balance; 
			cout <<"--------------------------------------"<<endl;
			string reg="REGISTER#" + name + "\n" + balance;
			//send the message to server
			send (socketfd, reg.c_str(), reg.length(), 0);
			recv (socketfd, recv_buf, local_buffer, 0);
			if(recv_buf[0]=='1'){
				for(int i=0;i<6;i++)
					cout << recv_buf[i];
				cout<<endl;
			} //print the received message
			if(recv_buf[0]=='2' || recv_buf[0]=='y'){
				for(int i=0;i<8;i++)
					cout << recv_buf[i];
				cout<<endl;
				cout<<"Please Register Again."<<endl;
			} // if the accunt have been registered, user should register again.
			cout << endl<<"Enter 1 for register, 2 for login:";
			cin >> choice;
		} else if (choice == "2"){//LOGIN
			cout << "Enter your name:";
			cin >> name;
			cout << "Enter the port number:";
			cin >> port;
			cout <<"--------------------------------------"<<endl;
			sprintf(recv_buf, "%s#%d\n", name.c_str(), port);
			send (socketfd, recv_buf, strlen(recv_buf), 0);
			if(recv(socketfd, recv_buf, local_buffer, 0)<local_buffer){
				for(int i=0;i<local_buffer;i++){	
				if(recv_buf[i]=='#')
					recv_buf[i]='\t';
				} // to print blank space instead of #
				cout << recv_buf << endl;
			}else{
				cout<<"Buffer Full"<<endl;
				recv_buf[0]='2';
			}
			if(recv_buf[0]=='2' || recv_buf[0]=='y'){
				cout<<"The account doesn't exist. Please try again."<<endl;
				// If the account doesn't exist. User should try it again.
				cout << endl<<"Enter 1 for register, 2 for login:";
				cin >> choice;
			}
			else 
				login_suc=true;
		} else { // error detection
			cout<<"Wrong Input! Try again."<<endl;
			cout <<"Enter 1 for register, 2 for login:";
			cin >> choice;
		}
	}
	
	
	
	cout << "log in successfully."<<endl;
	bool exit_socket=false;
	while(!exit_socket){
		cout << "Enter the number of actions u want to take." << endl;
		cout << "1 to ask for the latest list, 8 to exit:";
		string command;
		cin >> command;
		if (command == "1"){//ask the list
			send (socketfd, "List\n", 5, 0);
			if(recv(socketfd, recv_buf, local_buffer, 0)<local_buffer){
				for(int i=0;i<local_buffer;i++){	
				if(recv_buf[i]=='#')
					recv_buf[i]='\t';
				} // to print blank space instead of #
				cout << recv_buf << endl;
			}else{
				cout<<"Buffer Full"<<endl;
				exit_socket=true;
			}
			
		} else if (command == "8"){//quit
			send (socketfd, "Exit\n", 5, 0);
			recv(socketfd, recv_buf, local_buffer, 0);
			for(int i=0;i<3;i++){
				cout <<recv_buf[i];
			}
			cout <<endl;
			exit_socket=true;
		} else {//error detection
			cout << "Command does not exist. Try it again." << endl;
		}
	}
	
	close(socketfd);
	return 0;
}