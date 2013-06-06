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
    public partial class Form4 : Form
    {
        Form1 form;
        bool inicial;
        bool idioma;

        public Form4(Form1 formX, bool init, bool idiomas)
        {
            InitializeComponent();
            form = formX;
            inicial = init;
            XmlDocument fichero = new XmlDocument();
            fichero.Load("localizacion.xml");
            idioma = idiomas;
            if (idioma)
            {
                this.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/ventana").InnerText;
                this.button1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/botonConectOut").InnerText;
                this.button2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/botonCancelOut").InnerText;
                this.server.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textServer").InnerText;
                this.port.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textPort").InnerText;
                this.ddbb.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textDatabase").InnerText;
                this.user.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textUser").InnerText;
                this.pass.Text = fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textPass").InnerText;
            }
            else
            {
                this.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/ventana").InnerText;
                this.button1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/botonConectOut").InnerText;
                this.button2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/botonCancelOut").InnerText;
                this.server.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textServer").InnerText;
                this.port.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textPort").InnerText;
                this.ddbb.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textDatabase").InnerText;
                this.user.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textUser").InnerText;
                this.pass.Text = fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textPass").InnerText;
            }
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            XmlDocument fichero = new XmlDocument();
            fichero.Load("localizacion.xml");
            // Comprobamos que los valores mínimos y necesarios estén definidos
            if ((this.server.Text.Length > 0) && (this.server.Text != fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textServer").InnerText)
                && (this.server.Text != fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textServer").InnerText))
            {
                if (this.user.TextLength > 0)
                {
                    if (this.ddbb.TextLength > 0)
                    {
                        string ConnectionString;
                        // Definimos la ristra de conexión y se la enviamos a la ventana principal
                        if ((this.port.TextLength > 0) && (this.port.Text != fichero.SelectSingleNode("/localizacion/es/ventanaconexion/textPort").InnerText)
                            && (this.port.Text != fichero.SelectSingleNode("/localizacion/en/ventanaconexion/textPort").InnerText))
                            ConnectionString = "SERVER=" + this.server.Text + "; PORT=" + this.port.Text;
                        else
                            ConnectionString = "SERVER=" + this.server.Text;
                        ConnectionString += "; DATABASE=" + this.ddbb.Text + "; Uid=" + this.user.Text + ";";
                        if (this.pass.TextLength > 0)
                            ConnectionString += " PWD='" + this.pass.Text + "';";
                        ConnectionString += "Encrypt=true;";
                        form.setConnectionString(ConnectionString, this.ddbb.Text, this.server.Text);
                        form.Conectar(sender, e);
                    }
                    else
                    {
                        if (idioma)
                            MessageBox.Show(fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorDDBB1").InnerText, fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorDDBB2").InnerText);
                        else
                            MessageBox.Show(fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorDDBB1").InnerText, fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorDDBB2").InnerText);
                    }
                }
                else
                {
                    if(idioma)
                        MessageBox.Show(fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorUsuario1").InnerText, fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorUsuario2").InnerText);
                    else
                        MessageBox.Show(fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorUsuario1").InnerText, fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorUsuario2").InnerText);
                }
            }
            else
            {
                if(idioma)
                    MessageBox.Show(fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorServidor1").InnerText, fichero.SelectSingleNode("/localizacion/es/ventanaconexion/errorServidor2").InnerText);
                else
                    MessageBox.Show(fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorServidor1").InnerText, fichero.SelectSingleNode("/localizacion/en/ventanaconexion/errorServidor2").InnerText);
            }
        } 

        private void server_MouseDown(object sender, MouseEventArgs e)
        {
            server.Text = "";
        }

        private void port_MouseDown(object sender, MouseEventArgs e)
        {
            port.Text = "";
        }

        private void ddbb_MouseDown(object sender, MouseEventArgs e)
        {
            ddbb.Text = "";
        }

        private void user_MouseDown(object sender, MouseEventArgs e)
        {
            user.Text = "";
        }

        private void pass_MouseDown(object sender, MouseEventArgs e)
        {
            pass.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            form.Mostrar();
            this.Close();
            if (inicial == true)
                Application.Exit();
        }
    }
}
