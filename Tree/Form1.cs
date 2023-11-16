using System;
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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Tree
{
    public partial class Form1 : Form
    {
        string constring = "Host = localhost;Username = postgres;Password = postgres;Database = 2";
        List<int> faculty_ids = new List<int>();
        List<int> course_ids = new List<int>();
        List<int> group_ids = new List<int>();

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
                    n.ContextMenuStrip = contextMenuCourse;
                    n.Tag = (int)dr["faculty_id"];
                    treeView1.Nodes.Add(n);
                    faculty_ids.Add((int)dr["faculty_id"]);
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

                var sql = "select * from course where faculty_id = @id ORDER BY course_id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    var n = new TreeNode(dr["course_name"].ToString());
                    n.ContextMenuStrip = contextMenuCourse;
                    n.Tag = (int)dr["course_id"];
                    Parent.Nodes.Add(n);
                    course_ids.Add((int)dr["course_id"]);
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

                var sql = "select * from university_group where course_id = @id ORDER BY group_id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    var n = new TreeNode(dr["group_name"].ToString());
                    n.ContextMenuStrip = contextMenuCourse;
                    n.Tag = (int)dr["group_id"];
                    Parent.Nodes.Add(n);
                    group_ids.Add((int)dr["group_id"]);
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

                var sql = "delete from course where course_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteNonQuery();

                treeView1.SelectedNode.Remove();

                course_ids.Remove(id);

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

                var sql = "delete from university_group where group_id = @id";
                //var sql = "delete from university_group where group_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteNonQuery();

                treeView1.SelectedNode.Remove();

                group_ids.Remove(id);

                cn.Dispose();
            }
        }

        void DeleteFaculty()
        {
            if (treeView1.SelectedNode == null)
                return;

            int id = (int)treeView1.SelectedNode.Tag;

            using (var cn = NpgsqlDataSource.Create(constring))
            {
                cn.OpenConnection();

                var sql = "delete from faculty where faculty_id = @id";
                //var sql = "delete from university_group where group_id = @id";

                var cmd = cn.CreateCommand(sql);
                cmd.Parameters.AddWithValue("@id", id);

                var dr = cmd.ExecuteNonQuery();

                treeView1.SelectedNode.Remove();

                group_ids.Remove(id);

                cn.Dispose();
            }
        }

        void AddGroup(bool empty)
        {
            if (treeView1.SelectedNode == null)
                return;

            var frm = new AddForm();
            if (frm.ShowDialog() == DialogResult.OK)
            {
                int id = group_ids.Max() + 1;

                int course_id = 0;
                if (empty)
                    course_id = (int)treeView1.SelectedNode.Tag;
                else course_id = (int)treeView1.SelectedNode.Parent.Tag;

                string name = Help.Add;

                using (var cn = NpgsqlDataSource.Create(constring))
                {
                    cn.OpenConnection();

                    var sql = "INSERT INTO university_group VALUES (@id,@name,@course_id)";

                    var cmd = cn.CreateCommand(sql);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@course_id", course_id);

                    var dr = cmd.ExecuteNonQuery();

                    var n = new TreeNode(name);
                    n.Tag = id;
                    n.ContextMenuStrip = contextMenuCourse;

                    if (empty)
                        treeView1.SelectedNode.Nodes.Add(n);
                    else treeView1.SelectedNode.Parent.Nodes.Add(n);

                    group_ids.Add(id);

                    cn.Dispose();
                }
            }
        }

        void AddCourse(bool empty)
        {
            if (treeView1.SelectedNode == null)
                return;

            var frm = new AddForm();
            if (frm.ShowDialog() == DialogResult.OK)
            {
                int id = course_ids.Max() + 1;

                int faculty_id = 0;
                if (empty)
                    faculty_id = (int)treeView1.SelectedNode.Tag;
                else faculty_id = (int)treeView1.SelectedNode.Parent.Tag;

                string name = Help.Add;

                using (var cn = NpgsqlDataSource.Create(constring))
                {
                    cn.OpenConnection();

                    var sql = "INSERT INTO course VALUES (@id,@name,@faculty_id)";

                    var cmd = cn.CreateCommand(sql);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@faculty_id", faculty_id);

                    var dr = cmd.ExecuteNonQuery();

                    var n = new TreeNode(name);
                    n.Tag = id;
                    n.ContextMenuStrip = contextMenuCourse;

                    if (empty)
                        treeView1.SelectedNode.Nodes.Add(n);
                    else treeView1.SelectedNode.Parent.Nodes.Add(n);

                    course_ids.Add(id);

                    cn.Dispose();
                }
            }
        }

        void AddFaculty()
        {
            if (treeView1.SelectedNode == null)
                return;

            var frm = new AddForm();
            if (frm.ShowDialog() == DialogResult.OK)
            {
                int id = faculty_ids.Max() + 1;

                string name = Help.Add;

                using (var cn = NpgsqlDataSource.Create(constring))
                {
                    cn.OpenConnection();

                    var sql = "INSERT INTO faculty VALUES (@name,@id)";

                    var cmd = cn.CreateCommand(sql);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@name", name);

                    var dr = cmd.ExecuteNonQuery();

                    var n = new TreeNode(name);
                    n.Tag = id;
                    n.ContextMenuStrip = contextMenuCourse;

                    treeView1.Nodes.Add(n);

                    faculty_ids.Add(id);

                    cn.Dispose();
                }
            }
        }

        private void добавитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (treeView1.SelectedNode.Level == 0 && treeView1.SelectedNode.FirstNode != null)
                AddFaculty();
            if (treeView1.SelectedNode.Level == 0 && treeView1.SelectedNode.FirstNode == null)
                AddCourse(true);
            if (treeView1.SelectedNode.Level == 1 && treeView1.SelectedNode.FirstNode != null)
                AddCourse(false);
            if(treeView1.SelectedNode.Level == 1 && treeView1.SelectedNode.FirstNode == null)
                AddGroup(true);
            if (treeView1.SelectedNode.Level == 2)
                AddGroup(false);
        }

        private void изменитьToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void удалитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (treeView1.SelectedNode.Level == 0)
                DeleteFaculty();
            if (treeView1.SelectedNode.Level == 1)
                DeleteCourse();
            if (treeView1.SelectedNode.Level == 2)
                DeleteGroup();
        }
    }
}
