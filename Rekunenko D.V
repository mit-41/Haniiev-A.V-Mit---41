private void FillTheTable_Labs()
 {
 string tab = comboBox3.Text;
 int col = 0;
SqlDataReader myReader = null;
SqlCommand myCommand = new SqlCommand("select kol_l from discipline where
name_discip='" + tab + "'", myConnection);
myReader = myCommand.ExecuteReader();
while (myReader.Read())
{
col = Convert.ToInt32(myReader["kol_l"]);
 }
myReader.Close();
string zadlist = string.Empty; ;
for (int i = 0; i < col; i++)
zadlist += "'l" + (i + 1) + "',";
int index = zadlist.LastIndexOf(',');
zadlist = zadlist.Remove(index);
bool fl = true;
int k = 0;
try
{
myReader = null;
myCommand = new SqlCommand("select mark, name from eregister join discipline
on name_ds=discipline.cod join students on name_st=students.nomer " +
"where name_discip='" + tab + "' and cod_z in (" + zadlist + ")",
myConnection);
myReader = myCommand.ExecuteReader();
int i = 0;
while (myReader.Read())
{
if (fl)
{
if (!dobavleno_table4)
dataGridView4.Rows.Add();
dataGridView4.Rows[i].HeaderCell.Value = (i + 1).ToString();
dataGridView4[0, i].Value = myReader["name"].ToString();
k = 0;
fl = false;
}
if (myReader["mark"].ToString() == "n")
dataGridView4[k + 1, i].Value = false;
else
dataGridView4[k + 1, i].Value = true;
k++;
if (k == col)
{
 i++;
fl = true;
13
 }
 }
 myReader.Close();
 }
 catch (Exception exp)
 {
 label2.Text = exp.ToString();
 }
 }
 string nomer1 = numericUpDown1.Value.ToString();
 try
 {
 for (int i = 0; i < students_count; i++)
 {
 SqlCommand myCommand = new SqlCommand("update eregister set mark=@z "
 + "where cod_z='z"+nomer1+"' and name_st="+(i+1)+"", myConnection);
 SqlParameter myParam1 = new SqlParameter("@z", SqlDbType.Char, 1);
 if (Convert.ToBoolean(dataGridView2[0, i].Value))
 myParam1.Value = '1';
 else
 myParam1.Value = '0';

myCommand.Parameters.Add(myParam1);
myCommand.ExecuteNonQuery();
 }
 }
 catch (Exception exp)
 {
 label4.Text = exp.ToString();
 }
if (!dobavleno_pos)
 {
 dataGridView1.Columns.Add("Pos", "Пропуски");
 dobavleno_pos = true;
 }
 int count=0;
 for (int i = 0; i < students_count; i++)
 {
 for (int j = 3; j <= 3 + col_l + col_z; j++)
 if (dataGridView1[j, i].Value == "-")
 count++;
 dataGridView1["Pos", i].Value = count.ToString();
 count = 0;
 }
SqlDataReader myReader = null;
 SqlCommand myCommand = new SqlCommand("select name_prepod, polnomochiya
from teachers", myConnection);
 myReader = myCommand.ExecuteReader();
14
 int i = 0;
while (myReader.Read())
{
 comboBox1.Items.Add(myReader["name_prepod"].ToString());
 prepod_mas[i] = myReader["polnomochiya"].ToString();
i++;
 }
myReader.Close();
int n = comboBox1.SelectedIndex;
 label6.Text = prepod_mas[n];



