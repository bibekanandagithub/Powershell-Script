using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.IO;

namespace Team_OOPS
{
    class Program
    {
        static object baton = new object();
        static Random rand = new Random();

        static void Main(string[] args)
        {
            #region HIDE
            //List<string> AuthorList = new List<string>();
            //AuthorList.Add("Mahesh Chand");
            //AuthorList.Add("Praveen Kumar");
            //AuthorList.Add("Raj Kumar");
            //AuthorList.Add("Nipun Tomar");
            //AuthorList.Add("Dinesh Beniwal");


            //int searchlocation = AuthorList.BinarySearch("Raj Kumar");
            //Console.WriteLine("Location is {0} and value is {1}", searchlocation, AuthorList[searchlocation].ToString());
            //Console.Read();

            #endregion

            // getgroup();
            // DateTime dt = System.DateTime.Now;
            // Task task1 = Task.Factory.StartNew(Uniq);
            //Task task2 = Task.Factory.StartNew(GetBooksAll);
            // Task task3 = Task.Factory.StartNew(GetBooksAllGrouping);
            // Task.WaitAll(task1,task3,task2);
            // //GetBooksAll();
            // //Uniq();
            // DateTime dt2 = System.DateTime.Now;
            // TimeSpan ts = dt2 - dt;
            // Console.WriteLine(ts.Seconds.ToString());
            // Console.Read();


            #region Creation of task wait any
            //Task<int>[] tasks = new Task<int>[2];
            //tasks[0] = Task.Run(() =>
            // {

            //    for(int i=0;i<10;i++)
            //     {
            //         Thread.Sleep(1000);
            //         Console.WriteLine("Task1-{0}", i.ToString());
            //     }
            //     return 1;
            // });

            //tasks[1] = Task.Run(() =>
            //  {
            //      for (int i = 0; i < 10; i++)
            //      {
            //          Thread.Sleep(1000);
            //          Console.WriteLine("Task2-{0}", i.ToString());
            //      }
            //      return 1;

            //  });
            //while(tasks.Length>0)
            //{
            //    int i = Task.WaitAny(tasks);
            //    Task<int> completedtask = tasks[i];
            //    Console.WriteLine(completedtask.Result);

            //    var temp = tasks.ToList();
            //    temp.RemoveAt(i);
            //    tasks = temp.ToArray();
            //}

            //Console.WriteLine(Environment.NewLine + "Press any key to continue...");
            //Console.Read();


            #endregion

            #region taskwaitforall
            //Task<int>[] t = new Task<int>[3];
            //t[0] = Task.Run(() =>
            // {
            //     Thread.Sleep(1000);
            //     Console.WriteLine("task-1");
            //     return 1;
            // });
            //t[1] = Task.Run(() =>
            //  {
            //      Thread.Sleep(1000);
            //      Console.WriteLine("task-2");

            //      return 2;
            //  });
            //t[2] = Task.Run(() =>
            //  {
            //      Thread.Sleep(1000);
            //      Console.WriteLine("task-3");
            //      return 3;
            //  });
            //Task.WaitAll(t);
            //Console.WriteLine("Click any key to continue...");
            //Console.Read();


            #endregion


            #region taskexample

            Task[] t = new Task[2];
            string[] files = null;
            string[] dirs = null;
            string docsdirectory = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            t[0]=Task.Factory.StartNew(()=>
                {
                    Directory.GetFiles(docsdirectory);

                });

            t[1] = Task.Factory.StartNew(() =>

              {
                  Directory.GetDirectories(docsdirectory);
              });

            //Task.Factory.ContinueWhenAll
            

            #endregion  
        }
        public static void Uniq()
        {
            SqlConnection cc = new SqlConnection("server=.;database=master;uid=sa;pwd=47758");
            cc.Open();
            SqlCommand cmd = new SqlCommand("select * from emp", cc);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            cc.Close();

            foreach (DataRow dr in dt.AsEnumerable().Select(a=>a))
            {
                System.Threading.Thread.Sleep(1000);
                Console.WriteLine("ID {0} name  is {1} and Sal is {2}", dr["id"], dr["name"], dr["sal"]);
            }

        }
        static void UseRestRoomStall(object objectid)
        {
            Console.WriteLine(Thread.CurrentThread.ManagedThreadId + "  Trying to Obtain Bathroom Stall");

            lock (baton)
            {
                Console.WriteLine(Thread.CurrentThread.ManagedThreadId + " Obtain the lock and doing my business");
                Thread.Sleep(rand.Next(2000));

                Console.WriteLine(Thread.CurrentThread.ManagedThreadId + " Leaving the stall....");
            }

            Console.WriteLine(Thread.CurrentThread.ManagedThreadId + " is leaving the restruant..");

        }

        static void getgroup()
        {
            using (SqlConnection cc = new SqlConnection("server=.;database=SyncDBServer;integrated security=true"))
            {
                using (SqlCommand cmd = new SqlCommand("select * from tbl_group", cc))
                {
                    DataTable dt = new DataTable();
                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    adp.Fill(dt);

                    var groupedData = from b in dt.AsEnumerable()
                                      group b by b.Field<string>("runbyname") into g
                                      let list = g.ToList()
                                      select new
                                      {
                                          ChargeTag = g.Key,
                                          Count = list.Count,

                                          Billable = g.Where(row => row.Field<string>("outcome") == "passed").Count()
                                          
                                      };




                    foreach (var a in groupedData)
                    {
                        Console.WriteLine( a.ChargeTag+ "  "+a.Count+"   "+a.Billable);
                    }
                    Console.Read();

                }
            }
        }

        public static void GetBooksAll()
        {
            List<Books> boollist = new List<Books> { new Books {ISBN=38974923,BookName="ASP.NET",BookPrice=458 },
                new Books {ISBN=38974923,BookName="C#",BookPrice=858 },
                new Books {ISBN=38974923,BookName="F#.NET",BookPrice=925 }
            };

            var items = from b in boollist
                        select new {  b.BookName,  b.BookPrice };

      foreach(var a in items)
            {
                System.Threading.Thread.Sleep(1000);
                Console.WriteLine(a.BookName + "......." + a.BookPrice);
            }

    }


        public static Task GetBooksAllGrouping()
        {
            List<Books> boollist = new List<Books> { new Books {ISBN=38974923,BookName="ASP.NET",BookPrice=458 },
                new Books {ISBN=38974923,BookName="C#",BookPrice=858 },
                new Books {ISBN=38974923,BookName="F#.NET",BookPrice=925 }
            };

            var groupingis = from m in boollist
                             group m by m.ISBN into gprs
                             select new
                             {
                                 gprs.Key,
                                 sumsal=gprs.Sum(x=>x.BookPrice),
                                 avgsal=gprs.Average(y=>y.BookPrice)
                             };

            foreach(var a in groupingis)
            {
                Console.WriteLine(a.avgsal + a.sumsal);
            }
            return null;


        }
    }
    public class Books
    {
        public int ISBN { set; get; }
        public string BookName { set; get; }
        public float BookPrice { set; get; }

    }
}

