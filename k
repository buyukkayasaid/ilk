using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        DataTable datatablom = new DataTable();
        SqlConnection baglanti = new SqlConnection(@"server=sqlpc\sqlsunucu;database=rehber;user Id=admin;password=12345");
        SqlCommand komut = new SqlCommand();

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                baglanti.Open();
                MessageBox.Show("bağlantı sağlandı.");
                baglanti.Close();
            }
            catch (Exception hata)
            {
                MessageBox.Show(hata.ToString());   
                
            }

        }
        public void listeleme_yaparmisiniz_lutfen()
        { 
         datatablom.Clear();
            SqlDataAdapter adaptor = new SqlDataAdapter("select * from telefon",baglanti);
            adaptor.Fill(datatablom);
            dataGridView1.DataSource = datatablom;
        
        }

        private void Form1_Load(object sender, EventArgs e)
        {

            listeleme_yaparmisiniz_lutfen();

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text == "")
            {
                listeleme_yaparmisiniz_lutfen();
            }
            else
            {
                datatablom.Clear();
                SqlDataAdapter adaptor = new SqlDataAdapter("select * from telefon where ad like '%"+textBox1.Text+"%' ", baglanti);
                adaptor.Fill(datatablom);
                dataGridView1.DataSource = datatablom;
            
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                
                baglanti.Open();
                komut.Connection = baglanti;
                komut.CommandText="insert into telefon (ad,soyad,telefon,adres) values('"+textBox2.Text+"','"+textBox3.Text+"','"+textBox4.Text+"','"+textBox5.Text+"')";
                komut.ExecuteNonQuery();
                baglanti.Close();
                MessageBox.Show(textBox2.Text+" kayıt başarılı");
                textBox2.Text = "";
                textBox3.Text = "";
                textBox4.Text = "";
                textBox5.Text = "";
                listeleme_yaparmisiniz_lutfen();

            }
            catch (Exception hata)
            {
                MessageBox.Show(hata.ToString());
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                string silinecek = dataGridView1.CurrentRow.Cells[0].Value.ToString();
                DialogResult eminmisin;
                eminmisin = MessageBox.Show("silmek için onay ?", "silme", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

                if (eminmisin == DialogResult.Yes)
                {
                    baglanti.Open();
                    komut.Connection = baglanti;
                    komut.CommandText = "delete from telefon where id=" + silinecek;
                    komut.ExecuteNonQuery();
                    baglanti.Close();
                    MessageBox.Show(" silme başarılı");
                    listeleme_yaparmisiniz_lutfen();
                }
                else
                    MessageBox.Show("silme iptal edildi");


              
            }
            catch (Exception hata)
            {
                MessageBox.Show(hata.ToString());
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            textBox6.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();
            textBox7.Text = dataGridView1.CurrentRow.Cells[2].Value.ToString();
            textBox8.Text = dataGridView1.CurrentRow.Cells[3].Value.ToString();
            textBox9.Text = dataGridView1.CurrentRow.Cells[4].Value.ToString();

        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {

                baglanti.Open();
                komut.Connection = baglanti;
                komut.CommandText = "update telefon set ad='" + textBox6.Text + "',soyad='" + textBox7.Text + "',telefon='" + textBox8.Text + "',adres='" + textBox9.Text + "' where id='" + dataGridView1.CurrentRow.Cells[0].Value.ToString() + "' ";
   
                komut.ExecuteNonQuery();
                baglanti.Close();
                MessageBox.Show(" güncelleme başarılı");
                textBox6.Text = "";
                textBox7.Text = "";
                textBox8.Text = "";
                textBox9.Text = "";
                listeleme_yaparmisiniz_lutfen();

            }
            catch (Exception hata)
            {
                MessageBox.Show(hata.ToString());
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            listeleme_yaparmisiniz_lutfen();
        }
    }
}
