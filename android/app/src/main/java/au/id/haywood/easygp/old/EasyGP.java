package au.net.easygp.android;

import android.app.Activity;
import android.os.Bundle;
import android.widget.*;
import android.view.*;
import android.util.Log;
import java.sql.*;
import android.content.Intent;

public class EasyGP extends CommonActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);
    }

    public void okButton(View view) {
	String server;
	String database;
	String username;
	String password;
	String sql;
	String version;
	EditText editText = (EditText) findViewById(R.id.server);
	server = editText.getText().toString();
	editText = (EditText) findViewById(R.id.database);
	database = editText.getText().toString();
	editText = (EditText) findViewById(R.id.username);
	username = editText.getText().toString();
	editText = (EditText) findViewById(R.id.password);
	password = editText.getText().toString();
	try {
	    db.connect(server,database,username,password);
	    Intent intent = new Intent(this,PatientSearch.class);
	    startActivity(intent);
	} catch (Throwable e)  {
	    Log.wtf("EASYGP",e);
	    Toast.makeText(getApplicationContext(), (CharSequence) e.getMessage(), Toast.LENGTH_SHORT).show();
	}
    }

    public void cancelButton(View view) {
	finish();
    }
}
