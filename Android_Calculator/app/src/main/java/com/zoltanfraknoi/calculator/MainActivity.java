package com.zoltanfraknoi.calculator;

import android.support.annotation.StringDef;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.Interpolator;
import android.widget.Button;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity
{
    String textField = "0";
    double result = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar myToolbar = (Toolbar) findViewById(R.id.my_toolbar);
        setSupportActionBar(myToolbar);

    }
    // Menu icons are inflated just as they were with actionbar
    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.mymenu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.btnClear:
                // User chose the "Settings" item, show the app settings UI...
                resetStatus( (TextView)findViewById(R.id.lblResult) );
                return true;

            default:
                // If we got here, the user's action was not recognized.
                // Invoke the superclass to handle it.
                return super.onOptionsItemSelected(item);

        }
    }


    public void btnOnClick(View v)
    {

        TextView lblResult = (TextView) findViewById(R.id.lblResult);
        Button btnClicked = (Button) v;
        String btnClickedName = getResources().getResourceEntryName(btnClicked.getId());

        switch (btnClickedName)
        {
            case "btnPlus":
                break;
            case "btnMinus":
                break;
            case "btnDivide":
                break;
            case "btnMultiply":
                break;
            case "btnDot":
                placeDigit(lblResult, ".");
                break;
            case "btnEqual":

                break;
            default:
                if (tryParseInt(Character.toString(btnClickedName.charAt(3))))
                {
                    placeDigit(lblResult, Character.toString(btnClickedName.charAt(3)));
                }
        }


    }

    boolean tryParseInt(String value)
    {
        try
        {
            Integer.parseInt(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public void resetStatus(TextView lblResult)
    {
        textField = "0";
        result = 0;
        lblResult.setText(textField);
    }

    public void placeDigit(TextView lblResult, String digit)
    {
        if (textField == "0")
        {
            textField = "";
        }
        if ( !(textField.indexOf(".") > -1 && digit == ".") )
        {
            textField += digit;
            lblResult.setText(textField);
        }
    }


}
