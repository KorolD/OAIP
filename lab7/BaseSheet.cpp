#include "BaseSheet.h"
#define ABS(a) (a>=0)?(a):(-(a))  //������ ����� ��� include<math>

	BaseSheet::BaseSheet(int Amount){
		amount=Amount;
		stacks=new ItemStack[amount];
		return;
	}

	BaseSheet::~BaseSheet(){
		for(int i=0; i<amount; i++){
			stacks[i].~ItemStack();
		}
		delete stacks;
		return;
	}

	void BaseSheet::Add(int key, String data){
		stacks[ABS(key%amount)].Add(key,data);//����� ������� �� ������� ������ �������������
		return;
	}

	String* BaseSheet::FindKey(int key){
		struct Item* temp=stacks[ABS(key%amount)].FindKey(key);
		if(temp){
			return &(temp->data); //�.�. ���������� ���������
		}else{
			return NULL;
		}
	}

	void BaseSheet::DeleteKey(int key){
		stacks[ABS(key%amount)].DeleteKey(key);
		return;
	}

	String BaseSheet::ShowNum(int num){//�������� ���-�����: ��1-��1, ��2-��2, ��3-��3 ...
		return (IntToStr(num)+": "+stacks[num].Show());
	}

	int BaseSheet::GetLinesAmount(){
		return amount;
	}
