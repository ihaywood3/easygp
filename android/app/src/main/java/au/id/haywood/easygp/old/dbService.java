package au.net.easygp.android;

import android.os.Bundle;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;
import java.sql.*;
import android.app.Service;
import android.content.Intent;
import java.util.*;

public class dbService extends Service {
    // much of basic code from Google's example at http://developer.android.com/reference/android/app/Service.html

    private Connection conn;
    private boolean connected;
    private Bundle ctx;
    private Statement stmt; 
 
    /**
     * Class for clients to access.  Because we know this service always
     * runs in the same process as its clients, we don't need to deal with
     * IPC.
     */
    public class LocalBinder extends Binder {
        dbService getService() {
            return dbService.this;
        }
    }

    @Override
    public void onCreate() {
	connected = false;
	ctx = new Bundle ();
    }

    @Override
    public void onDestroy() {
	try {
	    conn.close();
	} catch (SQLException e) {
	    Log.wtf("EASYGP", e);
	}
    }

    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }

    // This is the object that receives interactions from clients.  See
    // RemoteService for a more complete example.
    private final IBinder mBinder = new LocalBinder();

 

    // actual SQL stuff: written by IH

    public boolean isConnected()  { return connected; }

    public void connect(String server, String database, String username, String password) throws SQLException
    {
	try {
	    Class.forName("org.postgresql.Driver");
	} catch (Throwable e) {
	    Log.wtf("EASYGP","Can't load postgres driver", e);
	}
	String url = "jdbc:postgresql://"+server+":5432/"+database+"?sslfactory=org.postgresql.ssl.NonValidatingFactory&ssl=true";
	conn = DriverManager.getConnection(url,username,password);
	Log.d("EASYGP","we are connected!");
    }

    public PreparedStatement query(String sql) throws SQLException {
	Log.d("EASYGP","preparing statement "+sql);
	return conn.prepareStatement(sql);
    }

    public List<Item> itemise(ResultSet rs, Class cls, Bundle inherited) throws SQLException {
	List l = new ArrayList<Item>() ;
	Item i;

	while (rs.next()) {
	    try {
		i = (Item) new PatientSearch.PatientItem();
		 i.loadData(rs,inherited);
		 l.add(i);
		 Log.d("EASYGP","loading a row");
	    } catch (Throwable e) { Log.wtf("EASYGP", e); }
	}
	return l;
    }
}