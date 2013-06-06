namespace WindowsFormsApplication1
{
    partial class Form4
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.server = new System.Windows.Forms.TextBox();
            this.user = new System.Windows.Forms.TextBox();
            this.pass = new System.Windows.Forms.TextBox();
            this.ddbb = new System.Windows.Forms.TextBox();
            this.port = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(106, 135);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "Conectar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // server
            // 
            this.server.Location = new System.Drawing.Point(36, 48);
            this.server.Name = "server";
            this.server.Size = new System.Drawing.Size(100, 20);
            this.server.TabIndex = 1;
            this.server.Text = "Servidor";
            this.server.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.server.MouseDown += new System.Windows.Forms.MouseEventHandler(this.server_MouseDown);
            // 
            // user
            // 
            this.user.Location = new System.Drawing.Point(167, 48);
            this.user.Name = "user";
            this.user.Size = new System.Drawing.Size(100, 20);
            this.user.TabIndex = 2;
            this.user.Text = "Usuario";
            this.user.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.user.MouseDown += new System.Windows.Forms.MouseEventHandler(this.user_MouseDown);
            // 
            // pass
            // 
            this.pass.Location = new System.Drawing.Point(299, 48);
            this.pass.Name = "pass";
            this.pass.Size = new System.Drawing.Size(100, 20);
            this.pass.TabIndex = 3;
            this.pass.Text = "Contraseña";
            this.pass.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.pass.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pass_MouseDown);
            // 
            // ddbb
            // 
            this.ddbb.Location = new System.Drawing.Point(102, 95);
            this.ddbb.Name = "ddbb";
            this.ddbb.Size = new System.Drawing.Size(100, 20);
            this.ddbb.TabIndex = 4;
            this.ddbb.Text = "Base de Datos";
            this.ddbb.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.ddbb.MouseDown += new System.Windows.Forms.MouseEventHandler(this.ddbb_MouseDown);
            // 
            // port
            // 
            this.port.Location = new System.Drawing.Point(235, 95);
            this.port.Name = "port";
            this.port.Size = new System.Drawing.Size(100, 20);
            this.port.TabIndex = 5;
            this.port.Tag = "";
            this.port.Text = "Puerto";
            this.port.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.port.MouseDown += new System.Windows.Forms.MouseEventHandler(this.port_MouseDown);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(260, 135);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 6;
            this.button2.Text = "Cancelar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // Form4
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(436, 215);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.port);
            this.Controls.Add(this.ddbb);
            this.Controls.Add(this.pass);
            this.Controls.Add(this.user);
            this.Controls.Add(this.server);
            this.Controls.Add(this.button1);
            this.Name = "Form4";
            this.Text = "Form4";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox server;
        private System.Windows.Forms.TextBox user;
        private System.Windows.Forms.TextBox pass;
        private System.Windows.Forms.TextBox ddbb;
        private System.Windows.Forms.TextBox port;
        private System.Windows.Forms.Button button2;
    }
}