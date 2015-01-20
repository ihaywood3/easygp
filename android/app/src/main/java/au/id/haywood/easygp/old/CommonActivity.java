package au.net.easygp.android;

import android.app.Activity;
import android.os.Bundle;
import android.os.IBinder;
import android.widget.*;
import android.view.*;
import android.util.Log;
import android.content.ServiceConnection;
import java.sql.*;
import java.util.*;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;

class CommonActivity extends Activity
{
    public final static String INHERITED_CONTEXT = "au.net.easygp.android.INHERITED";


    protected dbService db;
    private boolean mIsBound;
    protected PreparedStatement stmt; 
    protected ResultSet rs;
    protected Bundle ctx;

    private ServiceConnection mConnection = new ServiceConnection() {
	    public void onServiceConnected(ComponentName className, IBinder service) {
		// This is called when the connection with the service has been
		// established, giving us the service object we can use to
		// interact with the service.  Because we have bound to a explicit
		// service that we know is running in our own process, we can
		// cast its IBinder to a concrete class and directly access it.
		db = ((dbService.LocalBinder)service).getService();
		Log.d("EASYGP","LocalBinder getService()");
	    }
	
	    public void onServiceDisconnected(ComponentName className) {
		// This is called when the connection with the service has been
		// unexpectedly disconnected -- that is, its process crashed.
		// Because it is running in our same process, we should never
		// see this happen.
		db = null;
	    }
	};
    
    void doBindService() {
	// Establish a connection with the service.  We use an explicit
	// class name because we want a specific service implementation that
	// we know will be running in our own process (and thus won't be
	// supporting component replacement by other applications).
	Log.d("EASYGP","calling doBindService");
	Context ctx = this.getApplicationContext();
	ctx.bindService(new Intent(this, dbService.class), mConnection, Context.BIND_AUTO_CREATE);
	mIsBound = true;
    }
    
    void doUnbindService() {
	if (mIsBound) {
	    // Detach our existing connection.
	    Context ctx = this.getApplicationContext();
	    ctx.unbindService(mConnection);
	    mIsBound = false;
	}
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
	doBindService();

	Intent intent = getIntent();
	if (intent.hasExtra(INHERITED_CONTEXT))
	    ctx = intent.getBundleExtra(INHERITED_CONTEXT);
	else
	    ctx = new Bundle ();
    }

    @Override
    protected void onDestroy() {
	super.onDestroy();
	doUnbindService();
    }
    
    public void query(String sql) throws SQLException {
	stmt = db.query(sql);
    }

    public void runQuery() throws SQLException {
	rs = stmt.executeQuery();
    }
    
    public void stmtFromEditText(int i, int widget) throws SQLException {
	EditText edittext;

	edittext = (EditText) findViewById(widget);
	stmt.setString(i, edittext.getText().toString());
    }

    public void ctxToEditText(String field, int widget) throws SQLException {
	EditText edittext;

	edittext = (EditText) findViewById(widget);
	edittext.setText(ctx.getString(field));
    }	


    public void stmtFromCheckbox(int i, int widget) throws SQLException { 
	CheckBox cb;

	cb = (CheckBox) findViewById(widget);
	if (cb.isChecked())
	    {
		stmt.setString(i, "t");
	    }
	else
	    {
		stmt.setString(i, "f");
	    }
    }

    public void ctxToCheckbox(String field, int widget) {
	CheckBox cb;

	cb = (CheckBox) findViewById(widget);
	cb.setChecked(ctx.getBoolean(field));
    }

    public void stmtFromSpinner(int i, int widget) throws SQLException {
	Spinner sp;
        int pos;
	sp = (Spinner) findViewById(widget);
	pos = sp.getSelectedItemPosition();
	if (pos == -1)
	    stmt.setNull(i, Types.INTEGER);
	else
	    {
		pos ++;
		stmt.setInt(i, pos);
	    }
    }


    public void ctxToSpinner(String field, int widget) {
	Spinner sp;
	int pos;

	sp = (Spinner) findViewById(widget);
	pos = ctx.getInt(field);
	pos--;
	sp.setSelection(pos);
    }

    public void loadListView(List<Item> item_list) {
	ArrayAdapter adapter = new ArrayAdapter<Item>(this, android.R.layout.simple_list_item_1, item_list);
	final ListView lv = (ListView) findViewById(R.id.list);
	lv.setAdapter(adapter);
	lv.setClickable(true);
	lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int position, long arg3) {
		    Item i = (Item) lv.getItemAtPosition(position);
		    i.click();
		}
	    });	
    }


    public void handleSQLError(SQLException e) {
	Toast.makeText(getApplicationContext(), (CharSequence) e.getMessage(), Toast.LENGTH_SHORT).show();
	Intent intent = new Intent(this,EasyGP.class);
	startActivity(intent);
    }
}
