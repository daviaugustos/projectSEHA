﻿using ProjectSeha.Entity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;

namespace ProjectSeha.Models
{
    public class LembreteModel : ModelBase
    {
        public List<Lembrete> Read()
        {
            List<Lembrete> lista = new List<Lembrete>();

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            cmd.CommandText = "SELECT * FROM ViewLembretes";

            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Lembrete e = new Lembrete();

                    e.LembreteId = (int)reader["LembreteId"];
                    e.Data = (DateTime)reader["Data"];
                    e.Conteudo = (string)reader["Conteudo"];

                    lista.Add(e);
                }
                return lista;
            }
        }

        public void Create(Lembrete e)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"ArmazenaLembrete";

            cmd.Parameters.AddWithValue("@data", e.Data);
            cmd.Parameters.AddWithValue("@conteudo", e.Conteudo);

            cmd.ExecuteNonQuery();
        }

        public void Update(Lembrete e)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"AlteraLembrete";

            cmd.Parameters.AddWithValue("@conteudo", e.Conteudo);

            cmd.ExecuteNonQuery();
        }
        
        public void Delete(int id)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = @"ApagaLembrete";

            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
        }
    }
}