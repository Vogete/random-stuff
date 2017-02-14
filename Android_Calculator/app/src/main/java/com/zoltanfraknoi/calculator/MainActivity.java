package com.zoltanfraknoi.calculator;

import android.icu.math.BigDecimal;
import android.icu.text.DecimalFormat;
import android.icu.text.NumberFormat;
import android.renderscript.Double2;
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

import java.text.FieldPosition;
import java.text.ParsePosition;

public class MainActivity extends AppCompatActivity
{
    String textField = "0";
    double result = 0;
    int previousOperation = -1;
    boolean operationPressed = false;
    TextView lblResult;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar myToolbar = (Toolbar) findViewById(R.id.my_toolbar);
        setSupportActionBar(myToolbar);
        lblResult = (TextView)findViewById(R.id.lblResult);
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
        switch (item.getItemId())
        {
            case R.id.btnClear:
                // User chose the "Settings" item, show the app settings UI...
                resetStatus();
                return true;

            default:
                // If we got here, the user's action was not recognized.
                // Invoke the superclass to handle it.
                return super.onOptionsItemSelected(item);

        }
    }

    public void btnOnClick(View v)
    {
        Button btnClicked = (Button) v;
        String btnClickedName = getResources().getResourceEntryName(btnClicked.getId());

        if (Double.isInfinite(result) || Double.isNaN(result))
        {
            result = 0;
        }

        switch (btnClickedName)
        {
            case "btnPlus":
                calculate(1);
                operationPressed = true;
                break;
            case "btnMinus":
                calculate(2);
                operationPressed = true;
                break;
            case "btnMultiply":
                calculate(3);
                operationPressed = true;
                break;
            case "btnDivide":
                calculate(4);
                operationPressed = true;
                break;
            case "btnEqual":
                displayCalculation();
                operationPressed = true;
                break;
            case "btnDot":
                placeDigit(".");
                operationPressed = false;
            break;
            default:
                if (tryParseInt(Character.toString(btnClickedName.charAt(3))))
                {
                    placeDigit(Character.toString(btnClickedName.charAt(3)));
                    operationPressed = false;
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

    public void resetStatus()
    {
        textField = "0";
        result = 0;
        previousOperation = -1;
        operationPressed = false;
        lblResult.setText(textField);
    }

    public void placeDigit(String digit)
    {
        if (textField == "0" || operationPressed)
        {
            textField = "";
        }

        if ( !(textField.indexOf(".") > -1 && digit == ".") )
        {
            textField += digit;
            lblResult.setText(textField);
        }
    }

    public void calculate(int currentOperation){

        double number1;
        try
        {
            number1 = Double.parseDouble(lblResult.getText().toString());
        } catch (NumberFormatException e)
        {
            number1 = 0;
        }


        if (operationPressed)
        {
            previousOperation = currentOperation;
        } else {

            switch (previousOperation)
            {
                case 1:
                    result = result + number1;
                    break;
                case 2:
                    result = result - number1;
                    break;
                case 3:
                    result = result * number1;
                    break;
                case 4:
                    result = result / number1;
                    break;
                case 0:
                    result = number1;
                    break;
                case -1:
                    result = number1;
                    break;

            }
        }


        previousOperation = currentOperation;

    }

    public void displayCalculation()
    {
        calculate(0);

        java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("#.#########");
        lblResult.setText(decimalFormat.format(result));

    }

}
