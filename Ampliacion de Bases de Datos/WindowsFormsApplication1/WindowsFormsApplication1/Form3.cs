using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;

namespace WindowsFormsApplication1
{
    public partial class Form3 : Form
    {
        public string sentencia;
        int primero = 1;
        public Form3(bool idiomas)
        {
            InitializeComponent();
            comboBox1.SelectedIndex = 0;
            XmlDocument fichero = new XmlDocument();
            fichero.Load("localizacion.xml");
            if ( idiomas )
            {
                this.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/ventana").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/layout1").InnerText;
                this.label1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/texto1").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/layout2").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/texto2").InnerText;
                this.label3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/nombre").InnerText;
                this.label4.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/tipo").InnerText;
                this.label5.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/tam").InnerText;
                this.label6.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/Restricciones").InnerText;
                this.checkBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/ClavePrim").InnerText;
                this.checkBox2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/ClaveSec").InnerText;
                this.checkBox3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/ClaveExtern").InnerText;
                this.campo.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/FijarCampo").InnerText;
                this.cancelar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/botonCancelar").InnerText;
                this.aceptar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaTabla/botonAceptar").InnerText;
            }
            else
            {
                this.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/ventana").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/layout1").InnerText;
                this.label1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/texto1").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/layout2").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/texto2").InnerText;
                this.label3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/nombre").InnerText;
                this.label4.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/tipo").InnerText;
                this.label5.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/tam").InnerText;
                this.label6.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/Restricciones").InnerText;
                this.checkBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/ClavePrim").InnerText;
                this.checkBox2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/ClaveSec").InnerText;
                this.checkBox3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/ClaveExtern").InnerText;
                this.campo.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/FijarCampo").InnerText;
                this.cancelar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/botonCancelar").InnerText;
                this.aceptar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaTabla/botonAceptar").InnerText;
            }
        }

        private void campo_Click(object sender, EventArgs e)
        {
            if (textBox2.Text != null)
            {
                string combo;
                // Establecemos cada elemento para la consulta
                if (comboBox1.SelectedItem.ToString() == "AUTO_INCREMENT")
                    combo = "MEDIUMINT NOT NULL AUTO_INCREMENT";
                else
                    combo = comboBox1.SelectedItem.ToString();
                if (primero == 1)
                {
                    primero = 0;
                    if (numericUpDown1.Enabled == false)
                    {
                        sentencia += textBox2.Text + " " + combo + " "
                            + textBox3.Text;
                    }
                    else
                        sentencia += textBox2.Text + " " + " " + combo
                            + "(" + numericUpDown1.Text + ") " + textBox3.Text;
                }
                else
                {
                    if (numericUpDown1.Enabled == false)
                    {
                        sentencia += ", " + textBox2.Text + " " + combo + " "
                            + textBox3.Text;
                    }
                    else
                        sentencia += ", " + textBox2.Text + " " + combo
                            + "(" + numericUpDown1.Text + ") " + textBox3.Text;
                }
            }
            if (checkBox1.Checked)
            {
                sentencia += ", PRIMARY KEY (" + textBox2.Text + ") ";
            }
            if (checkBox2.Checked)
            {
                sentencia += ", KEY (" + textBox2.Text + ") ";
            }
            if (checkBox3.Checked)
            {
                sentencia += ", FOREIGN KEY (" + textBox2.Text + ") ";
            }
            textBox2.Clear();
            textBox3.Clear();
            checkBox1.Checked = false;
            checkBox2.Checked = false;
            checkBox3.Checked = false;
            comboBox1.SelectedIndex = 0;
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // En caso que el tipo no tenga tamaño, no permitimos añadirlo
            if (comboBox1.SelectedItem.Equals("DATETIME")|| comboBox1.SelectedItem.Equals("DATE")
			|| comboBox1.SelectedItem.Equals("TIMESTAMP")|| comboBox1.SelectedItem.Equals("AUTO_INCREMENT"))
            {
                numericUpDown1.Enabled = false;
            }
            else
                numericUpDown1.Enabled = true;
        }

        private void cancelar_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
        }

        private void aceptar_Click(object sender, EventArgs e)
        {
            sentencia = "CREATE TABLE " + textBox1.Text + " ( " + sentencia + ");";
            DialogResult = DialogResult.OK;
        }
    }
}
