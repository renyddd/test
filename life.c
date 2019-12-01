#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<windows.h>
#include<time.h>

#define High 38
#define Width 75

int cells[High][Width];
long long int cnt = 0;

void gotoxy(int x,int y)
{
	HANDLE 	handle = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD pos;
	pos.X = x;
	pos.Y = y;
	SetConsoleCursorPosition(handle,pos);
}

void startup()
{
	int i,j;
	for(i = 0; i < High; i++)
		for(j = 0; j < Width; j++)
		{
			cells[i][j] = rand() % 2;
		}
}

void show()
{
	gotoxy(0,0);
	int i,j;
	for(i = 0; i < High; i++)
	{
		for(j = 0; j < Width; j++)
		{
			if(cells[i][j])
				printf("*");
			else
				printf(" ");
		}
		printf("\n");
	}
	printf("\n%d",cnt);
	//Sleep(100);
}

void updateWithoutInput()
{
	int NewCells[High][Width];
	int NeibourNumber;
	int i,j;
	for(i = 1; i < High; i++)
	{
		for(j = 1; j < Width; j++)
		{
			NeibourNumber = cells[i-1][j-1]+cells[i-1][j]+cells[i-1][j+1]+cells[i][j-1]+cells[i][j+1]+cells[i+1][j-1]+cells[i+1][j]+cells[i+1][j+1];
			if(NeibourNumber == 3)
				NewCells[i][j] = 1;
			else if(NeibourNumber == 2)
				NewCells[i][j] = cells[i][j];
			else
				NewCells[i][j] = 0;
		}
	}
	for(i = 1; i < High; i++)
		for(j = 1; j < Width; j++)
			cells[i][j] = NewCells[i][j];
	cnt++;
}

void updateWithInput()
{

}

int main()
{
	startup();
	while(1)
	{
		show();
		updateWithoutInput();
		updateWithInput();
	}
	return 0;
}


















































































