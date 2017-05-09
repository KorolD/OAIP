#define FLOOR(a) (double(int((a)*10000+0.5))/10000)
						//��� ���������� double � int ���������� ������� �����
/*�.�. ��� ������������ ������ ����� ������ �� �������, ��� �������� ����������.
  ��, ���� ���������� ��������� ���������� ������, ��� �������� ����� ��������� � �������� ����� � ���������� ������
  ����� ������� "��� �� ���, ��� ����"
  ��� ������ �������������� ����������������
*/
#pragma hdrstop

#include "MainForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
class InheritantSheet* sheet=NULL;

bool IsInt(String s){ //true - ���� s ������� ������ �� ���� � �������� '-' ������ ��������
	if(!s.Length()){
		return false;
	}
	for(int i=1; i<=s.Length(); i++){
		if(s[i]>'9'||s[i]<'0'){
			if(i==1&&s[1]=='-'){
				continue;
			}else{
				return false;
			}
		}
	}
	return true;
}
void ShowSheet(){   //������� ��� ������� � ����1
	Form1->Memo1->Lines->Clear();
	if(sheet){
		for(int i=0; i<sheet->GetLinesAmount();i++){
			Form1->Memo1->Lines->Add(sheet->ShowNum(i));
		}
	}
	return;
}
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
	StringGrid1->Cells[0][0]="�����";
	StringGrid1->Cells[1][0]="��������";
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender) //���������
{
	int amount=1; //���-�� ���������
	while(IsInt(StringGrid1->Cells[0][amount])&&amount<100){
		amount++;
	}
	amount--;
	if(!amount){  //���� ����� ���������
		ShowSheet();
		return;
	}
	if(sheet){  //������� ������ �������
		sheet->~InheritantSheet();
	}
	sheet=new InheritantSheet(amount); //���-�� �������=���-�� ���������, ��� ������ ������
	for(int i=1; i<=amount; i++){      //� �������� ����� ���������
		sheet->Add(StringGrid1->Cells[0][i].ToInt(),StringGrid1->Cells[1][i]);
	}
	ShowSheet();
	return;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button3Click(TObject *Sender) //��������
{
	if(IsInt(Edit1->Text)){
		if(!sheet){ //���� ������� ��� ���, �� �������� ������� � 29 ��������
			sheet=new InheritantSheet(29);//29-������� �����, � ������ ��������� �����
		}                                 //��������� ������������� �� �������
		sheet->Add(Edit1->Text.ToInt(),Edit2->Text);
	}else{
		ShowMessage("������� ����� ����");
	}
	ShowSheet();
	return;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)//�������
{
	if(IsInt(Edit1->Text)){
		if(sheet){
			sheet->DeleteKey(Edit1->Text.ToInt());
		}else{
			ShowMessage("������� �����");
			return;
        }
		if(!sheet->GetAmountTotal()){
			sheet->~InheritantSheet();
			sheet=NULL;
		}
	}else{
		ShowMessage("������� ����� ����");
	}
	ShowSheet();
	return;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button4Click(TObject *Sender) //�����
{
	if(IsInt(Edit1->Text)){
		if(sheet){
			String* temp=sheet->FindKey(Edit1->Text.ToInt());
			if(temp){ //����� ��������� NULL, ���� ���� �� ������
				Memo1->Lines->Clear();
				Memo1->Lines->Add("����:");
				Memo1->Lines->Add(Edit1->Text);
				Memo1->Lines->Add("��������:");
				Memo1->Lines->Add(*temp);//����� ������������ ���������, �� ���� �������� �������,
			}else{                       //������� ����� ����������� �����
				Memo1->Lines->Clear();
				Memo1->Lines->Add("���� �� ������");
            }
		}else{
			ShowMessage("������� �����");
        }
	}else{
		ShowMessage("������� ����� ����");
	}
	return;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button5Click(TObject *Sender)//����� <= ��������
{
	if(sheet){
		if(!sheet->GetAmountTotal()){
			ShowMessage("������� �����");
		}else{
			double average=sheet->Average();
			Memo1->Lines->Clear();
			Memo1->Lines->Add("������� �������������� �� ������:");
			Memo1->Lines->Add(FloatToStr(FLOOR(average))); //���������� �������� �� 4 ����� ����� ,
			Memo1->Lines->Add("���������� ��������� � ������� ������ �������� ���� ������ ���:");
			Memo1->Lines->Add(IntToStr(sheet->LessThanOrEqual(average)));
        }
	}else{
		ShowMessage("������� �����");
	}
	return;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button7Click(TObject *Sender)//�����
{
	if(sheet){
		sheet->~InheritantSheet();
	}
	Close();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button6Click(TObject *Sender)//�������� �������
{
	ShowSheet();//������ ��� ������� ���������� �������, � � ���� ����� �� ���� �����
	return;     //�� ShowSheet() >>>> Button6Click(Sender)
}               //��� ����       >>>> ButtonShowSheetClick(Sender)
//---------------------------------------------------------------------------
