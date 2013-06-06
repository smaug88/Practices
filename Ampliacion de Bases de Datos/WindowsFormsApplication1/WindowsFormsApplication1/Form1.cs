using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Xml;
using System.Xml.XPath;


namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        string ConnectionString;
        string QueryString = "SELECT table_name FROM user_tables";
        string basedatos, servidor;
        string NonQueryString;
        DataSet Mi_DataSet = new DataSet();
        MySqlConnection connection;
        MySqlDataAdapter adapter;
        MySqlCommand command;
        string queryDataSet;
        string Tabla_sel;
        bool usuarios;
        bool idioma; // Idioma = 0 -> Inglés = 1 -> Español
        XmlDocument fichero;

        Form form;

        public Form1()
        {
            // Definimos el archivo de localización y las variables por defecto
            fichero = new XmlDocument();
            fichero.Load("localizacion.xml");
            idioma = true;
            InitializeComponent();
            pictureBox2.Visible = false;
            button4.Visible = false;
            // Llamamos a la ventana de conexión y ocultamos la ventana principal
            form = new WindowsFormsApplication1.Form4(this, true, idioma);
            form.Visible = true;
            this.Opacity = 0.0f;
            this.ShowInTaskbar = false;
            // Definimos los valores de cada elemento en función del idioma
            if (idioma)
            {
                this.button1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/botonConectar").InnerText;
                this.button2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/botonDesconectar").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/estado").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout1").InnerText;
                this.boton_consultar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsTabla").InnerText;
                this.boton_insertar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CrearTabla").InnerText;
                this.boton_modificar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ModTabla").InnerText;
                this.boton_borrar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/DelTabla").InnerText;
                this.consultar_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsUsuario").InnerText;
                this.crear_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CrearUsuario").InnerText;
                this.mod_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ModUsuario").InnerText;
                this.eliminiar_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/DelUsuario").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout2").InnerText;
                this.groupBox3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout3").InnerText;
                this.button3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Exec").InnerText;
                this.button4.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Guardar").InnerText;
                this.button5.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Eliminar").InnerText;
            }
            else
            {
                this.button1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonConectar").InnerText;
                this.button1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonConectar").InnerText;
                this.button2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonDesconectar").InnerText;
                this.label2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/estado").InnerText;
                this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout1").InnerText;
                this.boton_consultar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsTabla").InnerText;
                this.boton_insertar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CrearTabla").InnerText;
                this.boton_modificar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ModTabla").InnerText;
                this.boton_borrar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/DelTabla").InnerText;
                this.consultar_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsUsuario").InnerText;
                this.crear_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CrearUsuario").InnerText;
                this.mod_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ModUsuario").InnerText;
                this.eliminiar_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/DelUsuario").InnerText;
                this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout2").InnerText;
                this.groupBox3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout3").InnerText;
                this.button3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Exec").InnerText;
                this.button4.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Guardar").InnerText;
                this.button5.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Eliminar").InnerText;
            }
        }

        public void setConnectionString(string Connection_String_to_Set, string ddbb, string server)
        {
            ConnectionString = Connection_String_to_Set;
            basedatos = ddbb;
            servidor = server;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        public void Mostrar()
        {
            button4.Visible = false;
            pictureBox2.Visible = false;
            pictureBox1.Visible = true;
            this.Opacity = 1.0f;
            this.ShowInTaskbar = true;
        }

        public void Conectar(object sender, EventArgs e)
        {
            textBox1.ForeColor = Color.Black;
            using (connection = new MySqlConnection(ConnectionString))
            {
                try
                {
                    connection.Open();
                    // Obtenemos las tablas a mostrar
                    get_table_name_Click(sender, e);
                    if( idioma )
                        textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConexionEstablecida").InnerText;
                    else
                        textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConexionEstablecida").InnerText;
                    // Mostramos la ventana y ponemos la imagen correcta
                    pictureBox2.Visible = true;
                    pictureBox1.Visible = false;
                    this.Opacity = 1.0f;
                    this.ShowInTaskbar = true;
                    form.Close();
                }
                catch (Exception ex)
                {
                    textBox1.ForeColor = Color.Red;
                    form.Visible = true;
                    this.Opacity = 0.0f;
                    this.ShowInTaskbar = false; 
                    if (idioma)
                        MessageBox.Show(ex.Message, fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ErrorConexion").InnerText);
                    else
                        MessageBox.Show(ex.Message, fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ErrorConexion").InnerText);
                }
            }
        }

        public void button1_Click(object sender, EventArgs e)
        {
            // Llamamos a la ventana de conexión y ocultamos la ventana principal
            form = new WindowsFormsApplication1.Form4(this, true, idioma);
            form.Visible = true;
            this.Opacity = 0.0f;
            this.ShowInTaskbar = false;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // Cerramos la conexión y ponemos el botón rojo
            textBox1.ForeColor = Color.Black;
            if (pictureBox2.Visible == true)
            {
                connection.Close();
                Mi_DataSet.Clear();
                Mi_DataSet.Tables.Clear();
                dataGridView1.Columns.Clear();
                if (idioma)
                    textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/FinConexion").InnerText;
                else
                    textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/FinConexion").InnerText;
                pictureBox2.Visible = false;
                pictureBox1.Visible = true;
            }
            

        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.ForeColor = Color.Black;
            using (connection = new MySqlConnection(ConnectionString))
            {
                try
                {
                    Mi_DataSet.Clear();
                    Mi_DataSet.Tables.Clear();
                    dataGridView1.Columns.Clear();
                    //Limpiamos el datagridview

                    if (boton_consultar.Checked)
                    //si hacemos una consulta
                    {
                        if ((Tabla_sel == null)|| (Tabla_sel == ""))
                        {
                            if ( idioma )
                                MessageBox.Show(fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/errorSeleccion1").InnerText, fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/errorSeleccion2").InnerText);
                            else
                                MessageBox.Show(fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/errorSeleccion1").InnerText, fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/errorSeleccion2").InnerText);
                            return;
                        }
                        QueryString = "Select * from "+ Tabla_sel;
                        //se realizará un Select *
                        connection.Open();
                        adapter = new MySqlDataAdapter(QueryString, ConnectionString);
                        adapter.Fill(Mi_DataSet);
                        dataGridView1.DataSource = Mi_DataSet.Tables[0];
                        dataGridView1.AutoResizeColumns();
                        bindingSource1.DataSource = Mi_DataSet.Tables[0];
                        dataGridView1.ReadOnly = true;
                        //Se pone el datagridview en modo solo lectura
                        if (idioma)
                            textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsultaOK").InnerText;
                        else
                            textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsultaOK").InnerText;
                        usuarios = false;
                        get_table_name_Click(sender, e);

                    }
                    else
                    {
                        if (boton_borrar.Checked)
                        //Si queremos eliminar una tabla
                        {
                            usuarios = false;
                            //Se lanza la ventana para pedir confirmación
                            Form2 confirmacion = new Form2(Tabla_sel);
                            if (confirmacion.ShowDialog(this) == DialogResult.Yes)
                            {
                                NonQueryString = "DROP TABLE " + Tabla_sel;
                                command = connection.CreateCommand();
                                command.CommandText = NonQueryString;
                                connection.Open();
                                adapter = new MySqlDataAdapter(command);
                                command.ExecuteNonQuery();
                                if (idioma)
                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ElimTabla1").InnerText
                                        + Tabla_sel + fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ElimTabla2").InnerText;
                                else
                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ElimTabla1").InnerText
                                        + Tabla_sel + fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ElimTabla2").InnerText;
                                comboBox1.ResetText();
                                get_table_name_Click(sender, e);

                            }
                        }
                        else
                        {
                            if (boton_modificar.Checked)
                            {
                                usuarios = false;
                                //PRIMERO RECUPERAMOS LA TABLA

                                QueryString = "SELECT  * from " + Tabla_sel;
                                queryDataSet = "SELECT  * from " + Tabla_sel;
                                //se realizará un Select *
                                connection.Open();
                                adapter = new MySqlDataAdapter(QueryString, ConnectionString);
                                adapter.Fill(Mi_DataSet);
                                dataGridView1.DataSource = Mi_DataSet.Tables[0];
                                dataGridView1.AutoResizeColumns();
                                bindingSource1.DataSource = Mi_DataSet.Tables[0];
                                dataGridView1.ReadOnly = false;
                                button4.Visible = true;
                                if (idioma)
                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/RecTabla").InnerText;
                                else
                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/RecTabla").InnerText;
                            }
                            else
                            {
                                if (boton_insertar.Checked)
                                {
                                    usuarios = false;
                                    Form3 crear = new Form3(idioma);
                                    // Mostramos la ventana de creación de tabla
                                    if (crear.ShowDialog(this) == DialogResult.OK)
                                    {
                                        command = connection.CreateCommand();
                                        command.CommandText = crear.sentencia;
                                        connection.Open();
                                        adapter = new MySqlDataAdapter(command);
                                        command.ExecuteNonQuery();
                                        if (idioma)
                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CreateTabla").InnerText;
                                        else
                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CreateTabla").InnerText;
                                        get_table_name_Click(sender, e);
                                    }
                                }
                                else
                                {
                                    if (consultar_usuarios.Checked)
                                    {
                                        usuarios = true;
                                        QueryString = "select Host,User,Password,Select_priv,Insert_priv, Update_priv,Delete_priv,"+
                                            "Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv," +
                                            "References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, "+
                                            "Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv,"+
                                            "Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv, Event_priv,"+
                                            "Trigger_priv, Create_tablespace_priv, ssl_type, max_questions, max_updates, max_connections, "+
                                            "max_user_connections, plugin from mysql.user;";
                                        //se realizará un Select *
                                        connection.Open();
                                        adapter = new MySqlDataAdapter(QueryString, ConnectionString);
                                        adapter.Fill(Mi_DataSet);
                                        dataGridView1.DataSource = Mi_DataSet.Tables[0];
                                        dataGridView1.AutoResizeColumns();
                                        bindingSource1.DataSource = Mi_DataSet.Tables[0];
                                        dataGridView1.ReadOnly = true;
                                        //Se pone el datagridview en modo solo lectura
                                        if (idioma)
                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsultaOK").InnerText;
                                        else
                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsultaOK").InnerText;
                                        usuarios = true;
                                        get_table_name_Click(sender, e);
                                    }
                                    else
                                    {
                                        if (crear_usuarios.Checked)
                                        {
                                            usuarios = true;
                                            Form5 crear = new Form5(idioma, servidor);
                                            // Mostramos la ventana de creación de usuario
                                            if (crear.ShowDialog(this) == DialogResult.OK)
                                            {
                                                command = connection.CreateCommand();
                                                command.CommandText = crear.sentencia;
                                                connection.Open();
                                                adapter = new MySqlDataAdapter(command);
                                                command.ExecuteNonQuery();
                                                if (idioma)
                                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CreateUsuario").InnerText;
                                                else
                                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CreateUsuario").InnerText;
                                                get_table_name_Click(sender, e);
                                            }
                                        }
                                        else
                                        {
                                            if (mod_usuarios.Checked)
                                            {
                                                usuarios = true;
                                                // PRIMERO RECUPERAMOS LA TABLA
                                                // Con los parámetros necesarios (hay valores que son irrelevantes y dan problemas)
                                                QueryString = "select Host,User,Password,Select_priv,Insert_priv, Update_priv,Delete_priv," +
                                            "Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv," +
                                            "References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, " +
                                            "Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv," +
                                            "Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv, Event_priv," +
                                            "Trigger_priv, Create_tablespace_priv, ssl_type, max_questions, max_updates, max_connections, " +
                                            "max_user_connections, plugin from mysql.user;";
                                                queryDataSet = "select Host,User,Password,Select_priv,Insert_priv, Update_priv,Delete_priv," +
                                            "Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv," +
                                            "References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, " +
                                            "Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv," +
                                            "Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv, Event_priv," +
                                            "Trigger_priv, Create_tablespace_priv, ssl_type, max_questions, max_updates, max_connections, " +
                                            "max_user_connections, plugin from mysql.user;";
                                                //se realizará un Select *
                                                connection.Open();
                                                adapter = new MySqlDataAdapter(QueryString, ConnectionString);
                                                adapter.Fill(Mi_DataSet);
                                                dataGridView1.DataSource = Mi_DataSet.Tables[0];
                                                dataGridView1.AutoResizeColumns();
                                                bindingSource1.DataSource = Mi_DataSet.Tables[0];
                                                dataGridView1.ReadOnly = false;
                                                button4.Visible = true;
                                                if (idioma)
                                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CambGuardado").InnerText;
                                                else
                                                    textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CambGuardado").InnerText;

                                            }
                                            else
                                            {
                                                if (eliminiar_usuarios.Checked)
                                                {
                                                    usuarios = true;
                                                    //Se lanza la ventana para pedir confirmación
                                                    Form2 confirmacion = new Form2(Tabla_sel);
                                                    if (confirmacion.ShowDialog(this) == DialogResult.Yes)
                                                    {
                                                        NonQueryString = "DROP USER " + Tabla_sel;
                                                        command = connection.CreateCommand();
                                                        command.CommandText = NonQueryString;
                                                        connection.Open();
                                                        adapter = new MySqlDataAdapter(command);
                                                        command.ExecuteNonQuery();
                                                        if (idioma)
                                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ElimUsuario1").InnerText
                                                                + Tabla_sel + fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ElimUsuario2").InnerText;
                                                        else
                                                            textBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ElimUsuario1").InnerText
                                                                + Tabla_sel + fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ElimUsuario2").InnerText;
                                                        comboBox1.ResetText();
                                                        get_table_name_Click(sender, e);

                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    textBox1.ForeColor = Color.Red;
                    textBox1.Text = ex.Message;
                }
            }
        }

        private void get_table_name_Click(object sender, EventArgs e)
        {
            textBox1.ForeColor = Color.Black;
            //Función que recupera los nombres de las tablas del espacio de tablas del usuario
            //Esto se podría hacer quizás al conectar para tener disponibles los nombres
            if (usuarios)
            {
                QueryString = "select User from mysql.user;";
            }
            else
            {
                QueryString = "SELECT DISTINCT TABLE_NAME " +
                                       "FROM INFORMATION_SCHEMA.COLUMNS " +
                                       "WHERE TABLE_SCHEMA='" + basedatos + "';";
            }
            //Esta consulta devuelve los nombres de tabla

            using (MySqlConnection connection  = new MySqlConnection(ConnectionString))
            {
                MySqlCommand command = new MySqlCommand(QueryString, connection);
                //Declaramos el comando asociado a la consulta y la conexión inicial

                connection.Open();
                MySqlDataReader reader = command.ExecuteReader();
                comboBox1.Items.Clear();
                //Conectamos y ejecutamos la consulta

                try
                {
                    while (reader.Read()) //Mientras leamos del reader
                    {
                        comboBox1.Items.Add(reader.GetString(0));
                        //Añadimos el nombre de la tabla actual al ComboBox
                        //que se encuentra en la columna 0 del reader (leemos la string)
                    }
                }
                finally
                {
                    reader.Close();
                    connection.Close();
                    //Al terminar, cerramos el reader y la conexión
                }
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Tabla_sel = comboBox1.SelectedItem.ToString();
            //Cada vez que modificamos en el ComboBox la tabla, se actualiza Tabla_sel

        }

        private void button4_Click(object sender, EventArgs e)
        {
            textBox1.ForeColor = Color.Black;
            using (connection = new MySqlConnection(ConnectionString))
            {
                // Creamos la string del comando de modificación
                command = connection.CreateCommand();
                command.CommandText = queryDataSet;
                try
                {
                    connection.Open();
                    adapter = new MySqlDataAdapter(command);
                    MySqlCommandBuilder OCB = new MySqlCommandBuilder(adapter);
                    adapter.Update(Mi_DataSet.Tables[0]);
                    button4.Visible = false;
                    dataGridView1.ReadOnly = true;
                    textBox1.Text = "Los cambios han sido almacenados correctamente.";

                }
                catch (Exception ex)
                {
                    textBox1.ForeColor = Color.Red;
                    textBox1.Text = ex.Message;
                    button4.Visible = false;
                }

            }
        }

        private void boton_modificar_CheckedChanged(object sender, EventArgs e)
        {
            if (button4.Visible == true && boton_modificar.Checked == false)
            {
                button4.Visible = false;
            }
            if (button5.Visible == true && boton_modificar.Checked == false)
            {
                button5.Visible = false;
            }
        }

        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (boton_modificar.Checked && button4.Visible)
            {
                button5.Visible = true;
            }
            else
                button5.Visible = false;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Remove(dataGridView1.CurrentRow);
            button5.Visible = false;
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            idioma = true;
            this.button1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/botonConectar").InnerText;
            this.button2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/botonDesconectar").InnerText;
            this.label2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/estado").InnerText;
            this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout1").InnerText;
            this.boton_consultar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsTabla").InnerText;
            this.boton_insertar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CrearTabla").InnerText;
            this.boton_modificar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ModTabla").InnerText;
            this.boton_borrar.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/DelTabla").InnerText;
            this.consultar_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ConsUsuario").InnerText;
            this.crear_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/CrearUsuario").InnerText;
            this.mod_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/ModUsuario").InnerText;
            this.eliminiar_usuarios.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/DelUsuario").InnerText;
            this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout2").InnerText;
            this.groupBox3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/layout3").InnerText;
            this.button3.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Exec").InnerText;
            this.button4.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Guardar").InnerText;
            this.button5.Text = fichero.SelectSingleNode("/localizacion/es/ventanaprincipal/Eliminar").InnerText;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            idioma = false;
            this.button1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonConectar").InnerText;
            this.button1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonConectar").InnerText;
            this.button2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/botonDesconectar").InnerText;
            this.label2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/estado").InnerText;
            this.groupBox2.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout1").InnerText;
            this.boton_consultar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsTabla").InnerText;
            this.boton_insertar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CrearTabla").InnerText;
            this.boton_modificar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ModTabla").InnerText;
            this.boton_borrar.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/DelTabla").InnerText;
            this.consultar_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ConsUsuario").InnerText;
            this.crear_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/CrearUsuario").InnerText;
            this.mod_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/ModUsuario").InnerText;
            this.eliminiar_usuarios.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/DelUsuario").InnerText;
            this.groupBox1.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout2").InnerText;
            this.groupBox3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/layout3").InnerText;
            this.button3.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Exec").InnerText;
            this.button4.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Guardar").InnerText;
            this.button5.Text = fichero.SelectSingleNode("/localizacion/en/ventanaprincipal/Eliminar").InnerText;
        }
    }
}
