#include<iostream>
#include<sstream>
#include<fstream>
#include<string>
#include<algorithm>
#include<vector>
#include<string.h>

#pragma warning( disable : 4996 )

using namespace std;

int main(int argc, char* argv[])
{
	cout << "-------------------Input file example.txt-----------------" << endl;
	ifstream myfile(argv[1]);
	char del[20];
	int i = 0;
	while (argv[2][i] != '\0')
	{
		del[i] = argv[2][i];
		i++;
	}



	if (myfile.is_open())
	{
		char command[20];
		while (!myfile.eof())
		{
			myfile >> command;
			//cout << command << endl;
			if (strcmp(command, "reverse") == 0)
			{
				char str[256];
				myfile >> str;


				cout << "reverse " << str << endl;
				int i = 0;
				while (str[i])
					i++;
				for (int j = i - 1; j >= 0; j--)
					cout << str[j];
				cout << endl;
			}
			else if (strcmp(command, "split") == 0)
			{
				char str[256];
				myfile >> str;

				//cout << str << endl;
				cout << "split " << str << endl;
				char *s = strtok(str, del);

				while (s != NULL)
				{
					cout << s << " ";
					s = strtok(NULL, del);
				}

				cout << endl;
			}
		}
	}
	myfile.close();
	cout << "-------------------End of input file example.txt----------" << endl;
	cout << "*******************User input*****************************" << endl;
	char command[20];
	while (cin >> command)
	{
		if (strcmp(command, "reverse") == 0)
		{
			char str[256];
			cin >> str;

			//      cout << str << endl;
			int i = 0;
			while (str[i])
				i++;
			for (int j = i - 1; j >= 0; j--)
				cout << str[j];
			cout << endl;



		}
		else if (strcmp(command, "split") == 0)
		{
			char str[256];
			cin >> str;

			//cout << str << endl;

			char *s = strtok(str, del);

			while (s != NULL)
			{
				cout << s << " ";
				s = strtok(NULL, del);
			}

			cout << endl;

		}
		else if (strcmp(command, "exit") == 0)
		{
			break;
		}
	}


	system("pause");
	return 0;
}
