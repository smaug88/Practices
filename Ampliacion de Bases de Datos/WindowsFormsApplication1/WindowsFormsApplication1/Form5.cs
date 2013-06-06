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
    public partial class Form5 : Form
    {
        public string sentencia;
        int primero = 1;
        string servidor;
        public Form5(bool idioma, string server)
        {
            InitializeComponent();
            XmlDocument fichero = new XmlDocument();
            fichero.Load("localizacion.xml");
            servidor = server;
            if (idioma)
            {
                this.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/ventana").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/layout1").InnerText;
                this.label1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/label1").InnerText;
                this.label3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/label2").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/permisos").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/label3").InnerText;
                this.label4.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/permisos").InnerText;
                this.campo.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/agregarPermiso").InnerText;
                this.cancelar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/cancelar").InnerText;
                this.aceptar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaCreaUsuario/aceptar").InnerText;
            }
            else
            {
                this.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/ventana").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/layout1").InnerText;
                this.label1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/label1").InnerText;
                this.label3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/label2").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/permisos").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/label3").InnerText;
                this.label4.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/permisos").InnerText;
                this.campo.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/agregarPermiso").InnerText;
                this.cancelar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/cancelar").InnerText;
                this.aceptar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaCreaUsuario/aceptar").InnerText;
            }
        }

        private void aceptar_Click(object sender, EventArgs e)
        {
            sentencia = "CREATE USER '" + nombre.Text + "'@'"+ servidor + "' IDENTIFIED BY '" + pass.Text + "' ; " + "GRANT " + sentencia + 
                        " ON *.* TO '" + nombre.Text + "';";
            DialogResult = DialogResult.OK;
        }

        private void campo_Click(object sender, EventArgs e)
        {
            if (primero == 1)
            {
                sentencia = comboBox1.SelectedItem.ToString();
            }
            else
            {
                sentencia = " , " + comboBox1.SelectedItem.ToString();
            }
            comboBox1.ResetText();
        }

        private void cancelar_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
        }
    }
}
