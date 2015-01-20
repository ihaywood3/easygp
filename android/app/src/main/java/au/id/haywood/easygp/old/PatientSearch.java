package au.net.easygp.android;

import android.app.Activity;
import android.os.Bundle;
import android.widget.*;
import android.view.*;
import android.util.Log;
import java.sql.*;

public class PatientSearch extends CommonActivity
{

    public static class PatientItem extends Item
    {
	public PatientItem() 
	{
	    Log.d("EASYGP","doing nothing inside PatientItem");
	}

	public void click()
	{
	    //Toast.makeText(PatientSearch.this.getApplicationContext(), "selected patient "+data.getString("fk_patient"), Toast.LENGTH_SHORT).show();
	}
	public void right_click(int widget) {
	    Log.wtf("EASYGP","shouldn't get called");
	}
    }
    

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.patient_search);
    }

    public void searchButton(View view) {
	String searchtext;
	EditText et;
	
	try {
	    query("select fk_patient, wholename as display from contacts.vwpatients where surname ilike ?");
	    stmtFromEditText(1, R.id.search);
	    et = (EditText) findViewById(R.id.search);
	    searchtext = et.getText().toString();
	    searchtext = searchtext + "%";
	    stmt.setString(1, searchtext);
	    runQuery();
	    loadListView(db.itemise(rs,PatientItem.class, new Bundle()));
	}
	catch (SQLException e) { handleSQLError(e); }
    }

}