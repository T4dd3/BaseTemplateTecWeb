package it.unibo.tw.web.beans;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

public class Matrice {
	List<List<Float>> matrix;
	
	/* Metodi utility */
	public void calcola(List<List<Float>> B) {
		List<List<Float>> result = new ArrayList<List<Float>>();
		
		for (int i = 0; i < matrix.size(); i++) {
			List<Float> appoggio = new ArrayList<Float>();
			for (int j = 0; j < B.size(); j++) {
				appoggio.add(matrix.get(i).get(j) - B.get(i).get(j));
			}
			result.add(appoggio);
		}
	}
	public Matrice[] subMatrices() {
		Matrice[] ritorno = new Matrice[4];
		for (int i = 0; i < ritorno.length; i++)
			ritorno[i] = new Matrice();
		
		int numCols = matrix.get(0).size();
		int numRows = matrix.size();
		
		int halfHor = numCols / 2 + numCols % 2;
		int halfVert = numRows / 2 + numRows % 2;
		for (int i = 0; i < 4; i++) {
			int halfI = Math.floorDiv(i, 2);
			for (int j = halfI + (halfI *(halfVert - 1)) ; j < halfVert + halfVert*halfI; j++) {
				if (i % 2 == 0)
					ritorno[i].getMatrix().add(new ArrayList<>(matrix.get(j).subList(0, halfHor)));
				else
					ritorno[i].getMatrix().add(new ArrayList<>(matrix.get(j).subList(halfHor, numCols)));
			}
		}
	
		return ritorno;
	}
	
	/* Costruttori */
	public Matrice(List<List<Float>> A) {
		this.matrix = A;
	}
	public Matrice() {
		this(new ArrayList<List<Float>>());
	}
	
	/* Metodi Accessor */
	public List<List<Float>> getMatrix() {
		return matrix;
	}
	public void setMatrix(List<List<Float>> a) {
		matrix = a;
	}
}
