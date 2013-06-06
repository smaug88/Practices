namespace WindowsFormsApplication1
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.button1 = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.boton_consultar = new System.Windows.Forms.RadioButton();
            this.boton_insertar = new System.Windows.Forms.RadioButton();
            this.boton_modificar = new System.Windows.Forms.RadioButton();
            this.boton_borrar = new System.Windows.Forms.RadioButton();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.eliminiar_usuarios = new System.Windows.Forms.RadioButton();
            this.mod_usuarios = new System.Windows.Forms.RadioButton();
            this.crear_usuarios = new System.Windows.Forms.RadioButton();
            this.consultar_usuarios = new System.Windows.Forms.RadioButton();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label2 = new System.Windows.Forms.Label();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.bindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.button4 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.button7 = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(6, 36);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(81, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "Conectar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.SystemColors.Control;
            this.textBox1.Location = new System.Drawing.Point(33, 481);
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            this.textBox1.Size = new System.Drawing.Size(791, 20);
            this.textBox1.TabIndex = 1;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(6, 83);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(81, 23);
            this.button2.TabIndex = 2;
            this.button2.Text = "Desconectar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(737, 48);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(104, 23);
            this.button3.TabIndex = 3;
            this.button3.Text = "Ejecutar";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // boton_consultar
            // 
            this.boton_consultar.AutoSize = true;
            this.boton_consultar.Checked = true;
            this.boton_consultar.Location = new System.Drawing.Point(24, 22);
            this.boton_consultar.Name = "boton_consultar";
            this.boton_consultar.Size = new System.Drawing.Size(99, 17);
            this.boton_consultar.TabIndex = 4;
            this.boton_consultar.TabStop = true;
            this.boton_consultar.Text = "Consultar Tabla";
            this.boton_consultar.UseVisualStyleBackColor = true;
            // 
            // boton_insertar
            // 
            this.boton_insertar.AutoSize = true;
            this.boton_insertar.Location = new System.Drawing.Point(24, 45);
            this.boton_insertar.Name = "boton_insertar";
            this.boton_insertar.Size = new System.Drawing.Size(80, 17);
            this.boton_insertar.TabIndex = 5;
            this.boton_insertar.TabStop = true;
            this.boton_insertar.Text = "Crear Tabla";
            this.boton_insertar.UseVisualStyleBackColor = true;
            // 
            // boton_modificar
            // 
            this.boton_modificar.AutoSize = true;
            this.boton_modificar.Location = new System.Drawing.Point(24, 69);
            this.boton_modificar.Name = "boton_modificar";
            this.boton_modificar.Size = new System.Drawing.Size(123, 17);
            this.boton_modificar.TabIndex = 6;
            this.boton_modificar.TabStop = true;
            this.boton_modificar.Text = "Modificar datos tabla";
            this.boton_modificar.UseVisualStyleBackColor = true;
            this.boton_modificar.CheckedChanged += new System.EventHandler(this.boton_modificar_CheckedChanged);
            // 
            // boton_borrar
            // 
            this.boton_borrar.AutoSize = true;
            this.boton_borrar.Location = new System.Drawing.Point(24, 93);
            this.boton_borrar.Name = "boton_borrar";
            this.boton_borrar.Size = new System.Drawing.Size(91, 17);
            this.boton_borrar.TabIndex = 7;
            this.boton_borrar.TabStop = true;
            this.boton_borrar.Text = "Eliminar Tabla";
            this.boton_borrar.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.eliminiar_usuarios);
            this.groupBox1.Controls.Add(this.mod_usuarios);
            this.groupBox1.Controls.Add(this.crear_usuarios);
            this.groupBox1.Controls.Add(this.consultar_usuarios);
            this.groupBox1.Controls.Add(this.boton_borrar);
            this.groupBox1.Controls.Add(this.boton_modificar);
            this.groupBox1.Controls.Add(this.boton_insertar);
            this.groupBox1.Controls.Add(this.boton_consultar);
            this.groupBox1.Location = new System.Drawing.Point(215, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(324, 124);
            this.groupBox1.TabIndex = 9;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Seleccione una operación:";
            // 
            // eliminiar_usuarios
            // 
            this.eliminiar_usuarios.AutoSize = true;
            this.eliminiar_usuarios.Location = new System.Drawing.Point(166, 94);
            this.eliminiar_usuarios.Name = "eliminiar_usuarios";
            this.eliminiar_usuarios.Size = new System.Drawing.Size(100, 17);
            this.eliminiar_usuarios.TabIndex = 11;
            this.eliminiar_usuarios.TabStop = true;
            this.eliminiar_usuarios.Text = "Eliminar Usuario";
            this.eliminiar_usuarios.UseVisualStyleBackColor = true;
            // 
            // mod_usuarios
            // 
            this.mod_usuarios.AutoSize = true;
            this.mod_usuarios.Location = new System.Drawing.Point(166, 69);
            this.mod_usuarios.Name = "mod_usuarios";
            this.mod_usuarios.Size = new System.Drawing.Size(107, 17);
            this.mod_usuarios.TabIndex = 10;
            this.mod_usuarios.TabStop = true;
            this.mod_usuarios.Text = "Modificar Usuario";
            this.mod_usuarios.UseVisualStyleBackColor = true;
            // 
            // crear_usuarios
            // 
            this.crear_usuarios.AutoSize = true;
            this.crear_usuarios.Location = new System.Drawing.Point(166, 46);
            this.crear_usuarios.Name = "crear_usuarios";
            this.crear_usuarios.Size = new System.Drawing.Size(89, 17);
            this.crear_usuarios.TabIndex = 9;
            this.crear_usuarios.TabStop = true;
            this.crear_usuarios.Text = "Crear Usuario";
            this.crear_usuarios.UseVisualStyleBackColor = true;
            // 
            // consultar_usuarios
            // 
            this.consultar_usuarios.AutoSize = true;
            this.consultar_usuarios.Location = new System.Drawing.Point(166, 22);
            this.consultar_usuarios.Name = "consultar_usuarios";
            this.consultar_usuarios.Size = new System.Drawing.Size(113, 17);
            this.consultar_usuarios.TabIndex = 8;
            this.consultar_usuarios.TabStop = true;
            this.consultar_usuarios.Text = "Consultar Usuarios";
            this.consultar_usuarios.UseVisualStyleBackColor = true;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.pictureBox2);
            this.groupBox2.Controls.Add(this.pictureBox1);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.button2);
            this.groupBox2.Controls.Add(this.button1);
            this.groupBox2.Location = new System.Drawing.Point(33, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(171, 124);
            this.groupBox2.TabIndex = 10;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Conexión con la Base de Datos";
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(104, 65);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(40, 36);
            this.pictureBox2.TabIndex = 5;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(104, 64);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(40, 39);
            this.pictureBox1.TabIndex = 4;
            this.pictureBox1.TabStop = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(101, 42);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Estado:";
            // 
            // comboBox1
            // 
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(6, 22);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(170, 21);
            this.comboBox1.TabIndex = 11;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.comboBox1);
            this.groupBox3.Location = new System.Drawing.Point(545, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(186, 124);
            this.groupBox3.TabIndex = 12;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Seleccionar tabla:";
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(33, 162);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowTemplate.Height = 15;
            this.dataGridView1.Size = new System.Drawing.Size(791, 299);
            this.dataGridView1.TabIndex = 14;
            this.dataGridView1.RowHeaderMouseClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dataGridView1_RowHeaderMouseClick);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(737, 77);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(104, 23);
            this.button4.TabIndex = 15;
            this.button4.Text = "Guardar Cambios";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(737, 106);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(104, 23);
            this.button5.TabIndex = 16;
            this.button5.Text = "Eliminar fila";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Visible = false;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button6
            // 
            this.button6.Image = ((System.Drawing.Image)(resources.GetObject("button6.Image")));
            this.button6.Location = new System.Drawing.Point(737, 12);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(44, 35);
            this.button6.TabIndex = 17;
            this.button6.UseVisualStyleBackColor = true;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // button7
            // 
            this.button7.Image = ((System.Drawing.Image)(resources.GetObject("button7.Image")));
            this.button7.Location = new System.Drawing.Point(797, 12);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(44, 35);
            this.button7.TabIndex = 18;
            this.button7.UseVisualStyleBackColor = true;
            this.button7.Click += new System.EventHandler(this.button7_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(853, 530);
            this.Controls.Add(this.button7);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.textBox1);
            this.Name = "Form1";
            this.Text = "GOBD";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bindingSource1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.RadioButton boton_consultar;
        private System.Windows.Forms.RadioButton boton_insertar;
        private System.Windows.Forms.RadioButton boton_modificar;
        private System.Windows.Forms.RadioButton boton_borrar;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource bindingSource1;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.RadioButton eliminiar_usuarios;
        private System.Windows.Forms.RadioButton mod_usuarios;
        private System.Windows.Forms.RadioButton crear_usuarios;
        private System.Windows.Forms.RadioButton consultar_usuarios;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.Button button7;
    }
}

