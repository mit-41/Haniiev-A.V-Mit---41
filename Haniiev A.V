////////////////////////////////////////////////////Учёт лабораторных работ://///////////////////////////////////////////////////////

string tab = comboBox3.Text;

int nomer=comboBox2.SelectedIndex; try

{

SqlCommand myCommand;

SqlParameter myParam1 = new SqlParameter("@r1", SqlDbType.Char, 1); SqlParameter myParam4 = new SqlParameter("@nomer", SqlDbType.Int); myParam4.Value = nomer + 1;

for(int i=0;i<col_l;i++)

if (dataGridView3[i, 0].Value != null)

{

myCommand = new SqlCommand("update eregister set mark=@r1 from eregister inner join discipline on name_ds=discipline.cod "

+ "where name_st=@nomer and name_discip='" + tab + "' and cod_z='l"+(i+1)+"'", myConnection);

myParam1.Value = dataGridView3[i, 0].Value; myCommand.Parameters.Add(myParam1); myCommand.Parameters.Add(myParam4); myCommand.ExecuteNonQuery(); myCommand.Parameters.Clear();

}

}

catch (Exception exp)

{

label4.Text = exp.ToString();

}






/////////////////////////////////////////////Добавление нового предмета//////////////////////////////////////////////////////////////////

string name_ds = textBox1.Text; int count = 0;

SqlDataReader myReader = null;

SqlCommand myCommand = new SqlCommand("select COUNT(*) from discipline", Form1.myConnection);

myReader = myCommand.ExecuteReader(); while (myReader.Read())

{

count=Convert.ToInt32(myReader[""]);

}

myReader.Close();

string newcount = "0" + (count + 1);

myCommand = new SqlCommand("insert discipline (cod, name_discip) values ('"+newcount+"', '"+name_ds+"')", Form1.myConnection);
myCommand.ExecuteNonQuery(); label2.Text = "OK";



///////////////////////////////////////////////////Создание журнала по предмету///////////////////////////////////////////////////////

int col_z = Convert.ToInt32(numericUpDown1.Value);

int col_l = Convert.ToInt32(numericUpDown2.Value); SqlCommand myCommand;

for (int j = 0; j < 15; j++)

{

for (int i = 0; i < col_z; i++)

{

myCommand = new SqlCommand("insert eregister values ('" + cod_ds + "', 'z" + (i + 1) + "', 'n', '" + cod_pr + "', " + (j + 1) + ")", Form1.myConnection);

myCommand.ExecuteNonQuery();

}

for (int i = 0; i < col_l; i++)

{

myCommand = new SqlCommand("insert eregister values ('" + cod_ds + "', 'l" + (i + 1) + "', 'n', '" + cod_pr + "', " + (j + 1) + ")", Form1.myConnection);

myCommand.ExecuteNonQuery();

}

}

myCommand = new SqlCommand("update discipline set dob='1', kol_z="+col_z+", kol_l="+col_l+" where cod='"+cod_ds+"'", Form1.myConnection);

myCommand.ExecuteNonQuery(); label5.Text = "OK";

