﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace Tree
{
    public partial class Form1 : Form
    {
        string constring = "Host = localhost;Username = postgres;Password = postgres;Database = 2";

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            treeView1.Nodes.Clear();

            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();
                var sql = "select * from faculty";
                var cmd = cn.CreateCommand(sql);
                var dr = cmd.ExecuteReader();

                while(dr.Read())
                {
                    var n = new TreeNode(dr["faculty_name"].ToString());
                    treeView1.Nodes.Add(n);
                    LoadCourse((int)dr["faculty_id"],n);
                }
                cn.Dispose();
                dr.Dispose();
            }
        }

        void LoadCourse(int id,TreeNode Parent)
        {
            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();

                var sql = "select * from course where faculty_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    var n = new TreeNode(dr["course_name"].ToString());
                    n.ContextMenuStrip = contextMenuCourse;
                    n.Tag = (int)dr["faculty_id"];
                    Parent.Nodes.Add(n);
                    LoadGroup((int)dr["course_id"], n);
                }

                cn.Dispose();
                dr.Dispose();
            }
        }

        void LoadGroup(int id, TreeNode Parent)
        {
            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();

                var sql = "select * from university_group where course_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    var n = new TreeNode(dr["group_name"].ToString());
                    n.ContextMenuStrip = contextMenuCourse;
                    n.Tag = (int)dr["course_id"];
                    Parent.Nodes.Add(n);
                }

                cn.Dispose();
                dr.Dispose();
            }
        }

        void DeleteCourse()
        {
            if (treeView1.SelectedNode == null)
                return;

            int id = (int)treeView1.SelectedNode.Tag;


            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();

                var sql = "delete from course where faculty_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteNonQuery();

                treeView1.SelectedNode.Remove();

                cn.Dispose();
            }
        }

        void DeleteGroup()
        {
            if (treeView1.SelectedNode == null)
                return;

            int id = (int)treeView1.SelectedNode.Tag;


            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();

                var sql = "delete from university_group where course_id = @id";
                //var sql = "delete from university_group where group_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteNonQuery();

                treeView1.SelectedNode.Remove();

                cn.Dispose();
            }
        }

        private void добавитьToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void изменитьToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void удалитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //if(treeView1.SelectedNode.Level == 0)
            //    //DeleteGroup();
            if (treeView1.SelectedNode.Level == 1)
                DeleteCourse();
            if (treeView1.SelectedNode.Level == 2)
                DeleteGroup();
        }
    }
}
