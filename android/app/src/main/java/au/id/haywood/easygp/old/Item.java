package au.net.easygp.android;
import java.sql.*;
import android.os.Bundle;


public abstract class Item {
    
    protected Bundle data;

    Item() {}

    public void loadData(ResultSet row, Bundle inherited) throws SQLException {
	ResultSetMetaData rsmd = row.getMetaData();
	int i;

	data = new Bundle();
	data.putAll(inherited);
	for (i=1; i<=rsmd.getColumnCount(); i++) {
	    if (rsmd.getColumnType(i) == Types.INTEGER)
		data.putInt(rsmd.getColumnName(i),row.getInt(i));
	    else
		data.putString(rsmd.getColumnName(i),row.getString(i));
	}
    }

    public String toString () {
	if (data.containsKey("android_display"))
	    return data.getString("android_display");
	else
	    return data.getString("display");
    }

    public abstract void click();
    public abstract void right_click(int id);
    
}